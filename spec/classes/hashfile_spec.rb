# frozen_string_literal: true

require 'spec_helper'

describe 'hashfile' do
  let(:params) do
    {
      'ini' => {
        '/tmp/test1.ini' => {
          'file' => {
            'ensure' => 'present',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0666',
          },
          'data' => {
            'main' => {
              'key1' => 'value1',
              'key2' => 'value2',
              'dup_key' => ['dup_val1', 'dup_val2'],
            },
          },
        }
      }
    }
  end

  context 'hash to ini file' do
    it do
      is_expected.to contain_file('/tmp/test1.ini').with({ 'ensure' => 'present',
                                                           'owner'  => 'root',
                                                           'group'  => 'root',
                                                           'mode'   => '0666', })
    end

    it do
      is_expected.to contain_file('/tmp/test1.ini').with_content("# THIS FILE IS CONTROLLED BY PUPPET\n\n[main]\nkey1=\"value1\"\nkey2=\"value2\"\ndup_key=\"dup_val1\"\ndup_key=\"dup_val2\"\n")
    end

    it { is_expected.to contain_hashfile__ini('/tmp/test1.ini') }
  end
end
