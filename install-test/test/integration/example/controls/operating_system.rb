# # frozen_string_literal: true

control "operating_system" do
  describe os[:family] do
    it { should eq 'debian' }
  end
end
