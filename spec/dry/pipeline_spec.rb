require 'spec_helper'

describe Dry::Pipeline::Mixin do
  let(:fn1) do
    Class.new { include Dry::Pipeline::Mixin }.new(-> str { str.reverse })
  end

  let(:fn2) do
    Class.new { include Dry::Pipeline::Mixin }.new(-> str { str.upcase })
  end

  let(:fn3) do
    Class.new { include Dry::Pipeline::Mixin }.new(-> str { str.split(' ') })
  end

  let(:op) { -> str { str.upcase } }

  it 'provides >> operator' do
    pipeline = fn1 >> fn2

    expect(pipeline['hello world']).to eql('DLROW OLLEH')

    pipeline >>= fn3

    expect(pipeline['hello world']).to eql(%w(DLROW OLLEH))
  end
end
