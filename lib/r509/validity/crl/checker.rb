require "r509"
require 'rufus/scheduler'

#container module for the CRL Checker
module R509::Validity::CRL
  # implements the R509::Validity interface for CRL checking
  class Checker < R509::Validity::Checker
    attr_reader :crls

    def initialize(crl_paths,scheduler_interval='60m')
      @crl_paths = crl_paths
      load_crls
      @scheduler = Rufus::Scheduler.new

      @scheduler.every scheduler_interval do
        load_crls
      end
    end

    # @return [R509::Validity::Status]
    def check(issuer,serial)
      raise ArgumentError.new("Serial and issuer must be provided") if serial.to_s.empty? or issuer.to_s.empty?

      revocation_data = @crls[issuer.to_s][:revoked][serial.to_i]
      if revocation_data
        R509::Validity::Status.new(
          :status => R509::Validity::REVOKED,
          :revocation_time => revocation_data[:time].to_i,
          :revocation_reason => revocation_data[:reason]
        )
      else
        R509::Validity::Status.new(:status => R509::Validity::VALID)
      end
    end

    # helper method to load CRLs. Called when the class is instantiated and also by rufus on a configurable
    # interval.
    def load_crls
      @new_crls = {}
      @crl_paths.each do |crl|
        parsed = R509::CRL::SignedList.load_from_file(crl)
        @new_crls[parsed.issuer.to_s] = { :revoked => parsed.revoked, :next_update => parsed.next_update }
      end
      @crls = @new_crls
    end

    def is_available?
      true
    end
  end
end
