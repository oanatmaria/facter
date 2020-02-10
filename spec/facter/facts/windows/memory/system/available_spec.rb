# frozen_string_literal: true

describe 'Windows MemorySystemAvailable' do
  context '#call_the_resolver' do
    let(:value) { '1.00 KiB' }
    subject(:fact) { Facter::Windows::MemorySystemAvailable.new }

    before do
      allow(Facter::Resolvers::Memory).to receive(:resolve).with(:available_bytes).and_return(1024)
    end

    it 'calls Facter::Resolvers::Memory' do
      expect(Facter::Resolvers::Memory).to receive(:resolve).with(:available_bytes)
      fact.call_the_resolver
    end

    it 'returns free memory fact' do
      expect(fact.call_the_resolver).to be_an_instance_of(Array).and \
        contain_exactly(an_object_having_attributes(name: 'memory.system.available', value: value),
                        an_object_having_attributes(name: 'memoryfree', value: value, type: :legacy))
    end
  end
end