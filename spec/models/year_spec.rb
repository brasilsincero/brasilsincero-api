require 'rails_helper'

describe Year do
  describe '.find' do
    context 'when year is nil' do
      it 'returns the current year' do
        expect(described_class.find(nil)).to eql Time.current.year
      end
    end

    context 'when year is not informed' do
      it 'returns the current year' do
        expect(described_class.find(nil)).to eql Time.current.year
      end
    end

    context 'when year is valid' do
      context 'when year is an integer' do
        it 'returns the year as an integer' do
          expect(described_class.find(2011)).to eql 2011
        end
      end

      context 'when year is a string' do
        it 'returns the year as an integer' do
          expect(described_class.find('2011')).to eql 2011
        end
      end
    end

    context 'when year is invalid' do
      it 'raises an exception' do
        expect do
          described_class.find('2010')
        end.to raise_error(RecordNotFound, 'Year not found')
      end
    end
  end
end
