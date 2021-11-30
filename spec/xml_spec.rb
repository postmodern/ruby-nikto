require 'spec_helper'
require 'nikto/xml'

describe Nikto::XML do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'fixtures')) }
  let(:path) { File.join(fixtures_dir,'nikto.xml') }
  let(:xml) { File.read(path) }
  let(:doc) { Nokogiri::XML(File.open(path)) }

  subject { described_class.new(doc, path: path) }

  describe "#initialize" do
    it "must set #doc" do
      expect(subject.doc).to eq(doc)
    end

    context "when given a block" do
      it "must yield the new XML object" do
        expect { |b|
          described_class.new(xml,&b)
        }.to yield_with_args(described_class)
      end
    end

    context "when the path: keyword argument is not given" do
      subject { described_class.new(xml) }

      it "must set #path to nil" do
        expect(subject.path).to be(nil)
      end
    end

    context "when the path: keyword argument is given" do
      subject { described_class.new(xml, path: path) }

      it "must set #path" do
        expect(subject.path).to eq(path)
      end
    end
  end

  describe ".parse" do
    subject { described_class.parse(xml) }

    it "must parse the XML data" do
      expect(subject.doc).to be_kind_of(Nokogiri::XML::Document)
    end

    it "must set #path to nil" do
      expect(subject.path).to be(nil)
    end
  end

  describe ".open" do
    subject { described_class.open(path) }

    it "must open the file and parse the XML" do
      expect(subject.doc).to be_kind_of(Nokogiri::XML::Document)
    end

    it "must set #path" do
      expect(subject.path).to eq(path)
    end
  end

  describe "#hosts_test" do
    subject { super().hosts_test }

    it "must return the 'hoststest' attribute as an Integer" do
      expect(subject).to eq(doc.root['hoststest'].to_i)
    end
  end

  describe "#options" do
    subject { super().options }

    it "must return the 'options' attribute" do
      expect(subject).to eq(doc.root['options'])
    end
  end

  describe "#scan_start" do
    subject { super().scan_start }

    it "must return the 'scanstart' attribute as a Time object" do
      expect(subject).to eq(Time.parse(doc.root['scanstart']))
    end
  end

  describe "#scan_end" do
    subject { super().scan_end }

    it "must return the 'scanend' attribute as a Time object" do
      expect(subject).to eq(Time.parse(doc.root['scanend']))
    end
  end

  describe "#scan_elapsed" do
    subject { super().scan_elapsed }

    it "must return the 'scanelapsed' attribute" do
      expect(subject).to eq(doc.root['scanelapsed'])
    end
  end

  describe "#nikto_xml_version" do
    subject { super().nikto_xml_version }

    it "must return the 'nxmlversion' attribute" do
      expect(subject).to eq(doc.root['nxmlversion'])
    end
  end

  describe "#each_scan_details" do
    context "when given a block" do
      it "must yield each scan details" do
        expect { |b|
          subject.each_scan_details(&b)
        }.to yield_successive_args(described_class::ScanDetails)
      end
    end

    context "when no block is given" do
      subject { super().each_scan_details.to_a }

      it "must return an Enumerator of #{described_class}::ScanDetails" do
        expect(subject.length).to be(1)
        expect(subject[0]).to be_kind_of(described_class::ScanDetails)
      end
    end
  end

  describe "#scan_details" do
    subject { super().scan_details }

    it "must return an Array of #{described_class}::ScanDetails" do
      expect(subject.length).to be(1)
      expect(subject[0]).to be_kind_of(described_class::ScanDetails)
    end
  end

  describe "#target" do
    let(:scan_details) { subject.scan_details.first }
    let(:target)       { subject.target }

    it "must return the first #scan_details" do
      expect(target.target_ip).to eq(scan_details.target_ip)
      expect(target.target_hostname).to eq(scan_details.target_hostname)
      expect(target.target_port).to eq(scan_details.target_port)
      expect(target.target_banner).to eq(scan_details.target_banner)
      expect(target.start_time).to eq(scan_details.start_time)
      expect(target.site_name).to eq(scan_details.site_name)
      expect(target.site_ip).to eq(scan_details.site_ip)
      expect(target.host_header).to eq(scan_details.host_header)
      expect(target.errors).to eq(scan_details.errors)
      expect(target.checks).to eq(scan_details.checks)
    end
  end

  describe "#to_s" do
    context "when #path is set" do
      subject { described_class.open(path) }

      it "must return the #path" do
        expect(subject.to_s).to eq(path)
      end
    end

    context "when #path is nil" do
      subject { described_class.parse(xml) }

      it "must return the XML" do
        expect(subject.to_s).to eq(doc.to_s)
      end
    end
  end
end
