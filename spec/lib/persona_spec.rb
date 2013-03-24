require 'unit_spec_helper'

describe Persona do
  subject { Persona.new(audience: 'downthemall.com') }

  describe ".verify_assertion!" do
    it "raises InvalidResponse if status is not okay" do
      subject.stub(:request_assertion).with('XXX').and_return(OpenStruct.new(status: "fail"))
      expect(-> { subject.verify_assertion!('XXX') }).to raise_error(Persona::InvalidResponse)
    end
    it "raises InvalidResponse if audience returned does not match" do
      subject.stub(:request_assertion).with('XXX').and_return(OpenStruct.new(status: "okay", audience: 'foobar.com'))
      expect(-> { subject.verify_assertion!('XXX') }).to raise_error(Persona::InvalidResponse)
    end
    it "raises InvalidResponse if already expired" do
      Timecop.freeze(Time.new(2013, 3, 24)) do
        subject.stub(:request_assertion).with('XXX').and_return(OpenStruct.new(status: "okay", audience: 'downthemall.com', expires: 1364027501 ))
        expect(-> { subject.verify_assertion!('XXX') }).to raise_error(Persona::InvalidResponse)
      end
    end
    example "acceptance test" do
      puts Time.zone.inspect
      Timecop.freeze(Time.new(2013, 3, 24)) do
        VCR.use_cassette 'persona' do
          expect(subject.verify_assertion!('XXX').email).to eq 'stefano.verna@gmail.com'
        end
      end
    end
  end
end
