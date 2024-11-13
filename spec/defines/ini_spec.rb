# frozen_string_literal: true

require 'spec_helper'

describe 'hashfile::ini' do
  let(:params) do
    {
      file: {
        ensure: 'file',
      },
      data: {
        section1: {
          key1: 'value1',
          bool1: true,
        },
      },
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      if os.match?(%r{windows}i)
        let(:title) { 'C:\\Temp\\spec_ini.tmp' }
        it { is_expected.to contain_file('C:\\Temp\\spec_ini.tmp').with({ 'ensure' => 'file', }) }
        it { is_expected.to contain_file('C:\\Temp\\spec_ini.tmp').with_content("# THIS FILE IS CONTROLLED BY PUPPET\n\n[section1]\nkey1=\"value1\"\nbool1=\"true\"\n") }
      else
        let(:title) { '/tmp/spec_ini.tmp' }
        it { is_expected.to contain_file('/tmp/spec_ini.tmp').with({ 'ensure' => 'file', }) }
        it { is_expected.to contain_file('/tmp/spec_ini.tmp').with_content("# THIS FILE IS CONTROLLED BY PUPPET\n\n[section1]\nkey1=\"value1\"\nbool1=\"true\"\n") }
      end
      it { is_expected.to compile }
    end
  end
end
