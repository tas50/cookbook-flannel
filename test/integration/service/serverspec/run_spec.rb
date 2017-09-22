require 'serverspec'

set :backend, :exec

describe command '/usr/sbin/flanneld -version' do
  its :exit_status do
    should eq 0
  end

  its :stderr do
    should match(/0.5.5/)
  end
end

describe file '/run/flannel/subnet.env' do
  it 'should propagate the network' do
    expect(subject.content).to match %r{FLANNEL_NETWORK=10.0.0.0/8}
  end

  it 'shows a subnet lease' do
    expect(subject.content).to match %r{FLANNEL_SUBNET=10.0.\d+.1/24}
  end

  it 'has a false ipmasq' do
    expect(subject.content).to match(/FLANNEL_IPMASQ=false/)
  end
end
