require 'spec_helper'
require 'nikto/xml/scan_details'
require 'nokogiri'

describe Nikto::XML::ScanDetails do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'..','fixtures')) }
  let(:path) { File.join(fixtures_dir,'nikto.xml') }
  let(:xml)  { File.read(path) }
  let(:doc)  { Nokogiri::XML(File.open(path)) }
  let(:node) { doc.at_xpath('/niktoscan/scandetails') }

  subject { described_class.new(node) }

  describe "#target_ip" do
    subject { super().target_ip }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'targetip' attribute" do
      expect(subject).to eq(node['targetip'])
    end
  end

  describe "#target_hostname" do
    subject { super().target_hostname }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'targethostname' attribute" do
      expect(subject).to eq(node['targethostname'])
    end
  end

  describe "#target_port" do
    subject { super().target_port }

    it "must return the 'targetport' attribute as an Integer" do
      expect(subject).to eq(node['targetport'].to_i)
    end

    it "must be > 0" do
      expect(subject).to be > 0
    end
  end

  describe "#target_banner" do
    subject { super().target_banner }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'targetbanner' attribute" do
      expect(subject).to eq(node['targetbanner'])
    end
  end

  describe "#start_time" do
    subject { super().start_time }

    it "must return the 'starttime' attribute as a Time object" do
      expect(subject).to eq(Time.parse(node['starttime']))
    end
  end

  describe "#site_name" do
    subject { super().site_name }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'sitename' attribute" do
      expect(subject).to eq(node['sitename'])
    end
  end

  describe "#site_ip" do
    subject { super().site_ip }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'siteip' attribute" do
      expect(subject).to eq(node['siteip'])
    end
  end

  describe "#host_header" do
    subject { super().host_header }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'hostheader' attribute" do
      expect(subject).to eq(node['hostheader'])
    end
  end

  describe "#errors" do
    subject { super().errors }

    it "must return the 'errors' attribute as an Integer" do
      expect(subject).to eq(node['errors'].to_i)
    end
  end

  describe "#errors?" do
    context "when #errors is 0" do
      before { allow(subject).to receive(:errors).and_return(0) }

      it "must return false" do
        expect(subject.errors?).to be(false)
      end
    end

    context "when #errors is greater than 0" do
      before { allow(subject).to receive(:errors).and_return(1) }

      it "must return true" do
        expect(subject.errors?).to be(true)
      end
    end
  end

  describe "#checks" do
    subject { super().checks }

    it "must return the 'checks' attribute as an Integer" do
      expect(subject).to eq(node['checks'].to_i)
    end

    it "must be > 0" do
      expect(subject).to be > 0
    end
  end

  let(:item_count) { node.xpath('item').count }

  describe "#each_item" do
    context "when given a block" do
      it "must yield each Item object" do
        expect { |b|
          subject.each_item(&b)
        }.to yield_successive_args(*Array.new(item_count,Nikto::XML::Item))
      end
    end

    context "when no block is given" do
      subject { super().each_item.to_a }

      it "must return an Enumerator of Nikto::XML::Item objects" do
        expect(subject.length).to be(item_count)
        expect(subject).to all(be_kind_of(Nikto::XML::Item))
      end
    end
  end

  describe "#items" do
    subject { super().items}

    it "must return an Array of Nikto::XML::ScanDetails" do
      expect(subject.length).to be(item_count)
      expect(subject).to all(be_kind_of(Nikto::XML::Item))
    end
  end

  describe "#statistics" do
    subject { super().statistics }

    it "must return a Statistics object" do
      expect(subject).to be_kind_of(Nikto::XML::Statistics)
    end
  end
end
