describe UserInterface::Timer do
  let(:described_instance) { described_class.new {} }

  describe "#interval" do
    subject { described_instance.interval }

    it { is_expected.to eq(0) }

    context "when passed in on initialization" do
      let(:described_instance) { described_class.new(interval: 5) {} }

      it { is_expected.to eq(5) }
    end
  end

  describe "#repeats?" do
    subject { described_instance.repeats? }

    it { is_expected.to eq(false) }

    context "when passed in on initialization" do
      let(:described_instance) { described_class.new(repeats: true) {} }

      it { is_expected.to eq(true) }
    end
  end

  describe "#fire" do
    subject { described_instance.fire }

    context "when initialized with a block" do
      let(:result) { [] }
      let(:described_instance) do
        described_class.new do
          result << :success!
        end
      end

      it "runs the block" do
        expect { subject }
          .to change { result }
          .from([])
          .to([:success!])
      end
    end

    context "when initialized with an object and selector" do
      let(:result) { [nil, :success!] }
      let(:described_instance) do
        described_class.new(object: result, selector: :compact!)
      end

      it "runs the selector" do
        expect { subject }
          .to change { result }
          .from([nil, :success!])
          .to([:success!])
      end
    end
  end

  describe "#invalidate" do
    subject { described_instance.invalidate }

    it "changes the value of invalidated?" do
      expect { subject }
        .to change { described_instance.invalidated? }
        .from(false)
        .to(true)
    end
  end

  describe "#invalidated?" do
    subject { described_instance.invalidated? }

    it { is_expected.to eq(false) }
  end

  describe "#interval_elapsed?" do
    subject { described_instance.interval_elapsed? }

    it { is_expected.to eq(true) }

    context "when an interval is set" do
      let(:described_instance) do
        described_class.new(interval: 30) {}
      end

      it { is_expected.to eq(false) }

      context "when the time has passed" do
        before do
          # initialize before stubbing Time
          described_instance

          allow(Time)
            .to receive(:now)
            .and_return(Time.now + 1800)
        end

        it { is_expected.to eq(true) }
      end
    end
  end
end
