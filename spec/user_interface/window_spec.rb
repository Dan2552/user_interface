describe UserInterface::Window do
  let(:subviews) do
    allow(CoreStructures::BinarySortInsertArray)
      .to receive(:new) do
        []
      end
  end

  before do
    subviews
  end

  let(:frame) { double(:frame, position: double(:position), size: double(:size)) }
  let(:described_instance) { described_class.new(frame) }

  it "makes a graphics context with the position and size of the window" do
    expect(CoreGraphics::Context)
      .to receive(:new)
      .with(
        frame.position,
        frame.size
      )

    described_instance
  end

  describe "#view_controller" do
    subject { described_instance.view_controller }

    it { is_expected.to eq(nil) }

    it "can be set" do
      view_controller = UserInterface::ViewController.new

      expect(described_instance)
        .to receive(:add_subview)
        .with(view_controller.view)
      described_instance.view_controller = view_controller

      expect(subject).to eq(view_controller)
    end
  end

  describe "#window" do
    subject { described_instance.window }

    it { is_expected.to eq(described_instance) }
  end

  describe "#make_key" do
    subject { described_instance.make_key }

    it "sets the key window" do
      UserInterface::Application.create_shared

      expect(UserInterface::Application.shared)
        .to receive(:key_window=)
        .with(described_instance)

      subject
    end
  end

  describe "#make_key_and_visible" do
    subject { described_instance.make_key_and_visible }

    it "sets the key window" do
      UserInterface::Application.create_shared

      expect(UserInterface::Application.shared)
        .to receive(:key_window=)
        .with(described_instance)

      subject
    end

    context "when the window was previously hidden" do
      before do
        described_instance.hidden = true
      end

      it "makes it visible" do
        expect { subject }
          .to change { described_instance.hidden }
          .from(true)
          .to(false)
      end
    end
  end

  describe "#graphics_context" do
    subject { described_instance.graphics_context }

    it { is_expected.to be_a(CoreGraphics::Context) }
  end
end
