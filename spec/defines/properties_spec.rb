# frozen_string_literal: true

require 'spec_helper'

describe 'hashfile::properties' do
  let(:params) do
    {
      file: {
        ensure: 'file',
      },
      data: {
        section1: {
          key1: 'value1',
          key2: 'value2',
        },
      },
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      if os.match?(%r{windows}i)
        let(:title) { 'C:\\Temp\\spec.prop' }
        it { is_expected.to contain_file('C:\\Temp\\spec.prop').with({ 'ensure' => 'file', }) }
        it { is_expected.to contain_file('C:\\Temp\\spec.prop').with_content("# THIS FILE IS CONTROLLED BY PUPPET\n\nsection1.key1=value1\nsection1.key2=value2\n") }
      else
        let(:title) { '/tmp/spec.prop' }
        it { is_expected.to contain_file('/tmp/spec.prop').with({ 'ensure' => 'file', }) }
        it { is_expected.to contain_file('/tmp/spec.prop').with_content("# THIS FILE IS CONTROLLED BY PUPPET\n\nsection1.key1=value1\nsection1.key2=value2\n") }
      end
      it { is_expected.to compile }
    end
  end
end
