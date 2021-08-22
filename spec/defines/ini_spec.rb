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
        },
      },
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      if os.match?(%r{windows}i)
        let(:title) { 'C:\\Temp\\spec_ini.tmp' }
      else
        let(:title) { '/tmp/spec_ini.tmp' }
      end
      it { is_expected.to compile }
    end
  end
end
