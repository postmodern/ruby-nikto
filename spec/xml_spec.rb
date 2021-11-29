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

    it "must parse the XML data"

    it "must set #path to nil" do
      expect(subject.path).to be(nil)
    end
  end

  describe ".open" do
    subject { described_class.open(path) }

    it "must open the file and parse the XML"

    it "must set #path" do
      expect(subject.path).to eq(path)
    end
  end
end
