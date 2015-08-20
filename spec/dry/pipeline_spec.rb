require 'spec_helper'

describe Dry::Pipeline::Mixin do
  let(:fn1) do
    Dry::Pipeline.new(&:reverse)
  end

  let(:fn2) do
    Dry::Pipeline.new(-> str { str.upcase })
  end

  let(:fn3) do
    Dry::Pipeline.new(-> str { str.split(' ') })
  end

  let(:op) { -> str { str.upcase } }

  it 'provides >> operator' do
    pipeline = fn1 >> fn2

    expect(pipeline['hello world']).to eql('DLROW OLLEH')

    pipeline >>= fn3

    expect(pipeline['hello world']).to eql(%w(DLROW OLLEH))
  end
end
