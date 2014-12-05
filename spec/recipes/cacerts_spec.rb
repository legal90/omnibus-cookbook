require 'spec_helper'

describe 'omnibus::_cacerts' do
  let(:chef_run) { ChefSpec::ServerRunner.converge(described_recipe) }

  it 'includes _bash' do
    expect(chef_run).to include_recipe('omnibus::_bash')
  end

  context 'on freebsd' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'freebsd', version: '9.1')
        .converge(described_recipe)
    end

    it 'creates the .cacerts' do
      expect(chef_run).to create_file('/home/omnibus/.bashrc.d/cacerts.sh')
        .with_owner('omnibus')
        .with_mode('0755')
    end
  end
end
