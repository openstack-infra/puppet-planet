require 'puppet-openstack_infra_spec_helper/spec_helper_acceptance'

describe 'planet' do

  def pp_path
    base_path = File.dirname(__FILE__)
    File.join(base_path, 'fixtures')
  end

  def puppet_manifest
    manifest_path = File.join(pp_path, 'default.pp')
    File.read(manifest_path)
  end

  it 'should work with no errors' do
    apply_manifest(puppet_manifest, catch_failures: true)
  end

  it 'should be idempotent' do
    apply_manifest(puppet_manifest, catch_changes: true)
  end

  describe command('cd /var/lib/planet/openstack && planet /var/lib/planet/openstack/planet.ini') do
    its(:exit_status) { should eq 0 }
  end

  describe command('curl http://localhost') do
    its(:stdout) { should contain('<title>Planet OpenStack</title>') }
  end

end
