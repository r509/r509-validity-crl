require "spec_helper"

describe R509::Validity::CRL::Checker do
  before :all do
    @path = File.dirname(__FILE__) + '/fixtures/tw.crl'
    @path2 = File.dirname(__FILE__) + '/fixtures/digi.crl'
  end
  it "initializes with custom scheduler interval" do
    expect { R509::Validity::CRL::Checker.new([],'30m') }.to_not raise_error
  end
  it "loads a single CRL" do
    checker = R509::Validity::CRL::Checker.new([@path])
    checker.crls.size.should == 1
  end
  it "loads multiple CRLs" do
    checker = R509::Validity::CRL::Checker.new([@path,@path2])
    checker.crls.size.should == 2
  end
  it "gets valid" do
    checker = R509::Validity::CRL::Checker.new([@path,@path2])
    status = checker.check('/C=US/O=SecureTrust Corporation/CN=SecureTrust CA',28343844)
    status.status.should == R509::Validity::VALID
    status2 = checker.check('/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance EV CA-1',12345)
    status2.status.should == R509::Validity::VALID
  end
  it "gets revoked" do
    checker = R509::Validity::CRL::Checker.new([@path,@path2])
    status = checker.check('/C=US/O=SecureTrust Corporation/CN=SecureTrust CA',1073741988)
    status.status.should == R509::Validity::REVOKED
    status.revocation_time.should == 1193349017
    status2 = checker.check('/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance EV CA-1',16849924485970054612761793550114076650)
    status2.status.should == R509::Validity::REVOKED
    status2.revocation_time.should == 1323439403
    status2.revocation_reason.should == 'Unspecified'
  end
  it "next_update is cached from the parsed CRLs" do
    checker = R509::Validity::CRL::Checker.new([@path,@path2])
    checker.crls['/C=US/O=SecureTrust Corporation/CN=SecureTrust CA'][:next_update].to_i.should == 1375401002
    checker.crls['/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance EV CA-1'][:next_update].to_i.should == 1375808400
  end
end
