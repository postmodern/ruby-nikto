require 'spec_helper'
require 'nikto/command'

describe Nikto::Command do
  describe described_class::OptionString do
    let(:map) do
      {
        :a => '1',
        :b => '2',
        :c => '3'
      }
    end

    subject { described_class.new(map) }

    describe "#initialize" do
      it "must initialize #type to be a Map of the options" do
        expect(subject.type).to be_kind_of(CommandMapper::Types::Map)
        expect(subject.type.map).to eq(map)
      end

      it "must set #separator to ''" do
        expect(subject.separator).to eq('')
      end
    end
  end

  describe described_class::PortList do
    describe "#validate" do
      context "when given a single port number" do
        let(:value) { 443 }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end
      end

      context "when given a Range of port numbers" do
        let(:value) { (1..1024) }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end
      end

      context "when given an Array of port numbers" do
        let(:value) { [80, 443] }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end

        context "and the Array contains Ranges" do
          let(:value) { [80, (1..42), 443] }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end
      end
    end

    describe "#format" do
      context "when given a single port number" do
        let(:value) { 443 }

        it "must return the formatted port number" do
          expect(subject.format(value)).to eq(value.to_s)
        end
      end

      context "when given a Range of port numbers" do
        let(:value) { (1..1024) }

        it "must return the formatted port number range (ex: 1-102)" do
          expect(subject.format(value)).to eq("#{value.begin}-#{value.end}")
        end
      end

      context "when given an Array of port numbers" do
        let(:value) { [80, 443] }

        it "must return the formatted list of port numbers" do
          expect(subject.format(value)).to eq(value.join(','))
        end

        context "and the Array contains Ranges" do
          let(:value) { [80, (1..42), 443] }

          it "must return the formatted list of port numbers and port ranges" do
            expect(subject.format(value)).to eq("#{value[0]},#{value[1].begin}-#{value[1].end},#{value[2]}")
          end
        end
      end
    end
  end
end
