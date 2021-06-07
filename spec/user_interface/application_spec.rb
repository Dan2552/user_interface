describe UserInterface::Application do
  let(:described_instance) { described_class.new }

  describe ".shared" do
    subject { described_class.shared }

    before do
      described_class.instance_variable_set(:"@shared", nil)
    end

    it "raises" do
      expect { subject }
        .to raise_error("Application shared state is lost")
    end
  end

  describe ".create_shared" do
    subject { described_class.create_shared }

    it "creates the shared instance" do
      subject
      expect(described_class.shared).to be_a(described_class)
    end
  end

  describe "#windows" do
    subject { described_instance.windows }
    it { is_expected.to be_empty }
  end

  describe "#delegate" do
    subject { described_instance.delegate }
    it { is_expected.to be_an(AppDelegate) }
  end

  describe "#key_window" do
    subject { described_instance.key_window }
    it { is_expected.to eq(nil) }
  end
end
