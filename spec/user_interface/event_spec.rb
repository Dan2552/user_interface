describe UserInterface::Event do
  let(:described_instance) { described_class.new }

  describe "#type" do
    subject { described_instance.type }

    it { is_expected.to eq(nil) }

    context "when set to a value" do
      before do
        described_instance.instance_variable_set(:"@type", described_class::SDL_KEYDOWN)
      end

      it "returns the matching symbol" do
        expect(subject).to eq(:keydown)
      end
    end
  end

  describe "#inspect" do
    subject { described_instance.inspect }

    it { is_expected.to be_a(String) }
  end
end
