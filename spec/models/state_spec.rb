require 'rails_helper'

describe State do
  describe '.find' do
    context 'when state is nil' do
      it 'returns nil' do
        expect(described_class.find(nil)).to be_nil
      end
    end

    context 'when state is not informed' do
      it 'returns nil' do
        expect(described_class.find).to be_nil
      end
    end

    context 'when state is valid' do
      it 'returns the upcase state' do
        expect(described_class.find('se')).to eql 'SE'
      end
    end

    context 'when state is invalid' do
      it 'raises an exception' do
        expect do
          described_class.find('ss')
        end.to raise_error(RecordNotFound, 'State not found')
      end
    end
  end
end
