describe UserInterface::View do
  let(:frame) { double(:frame, position: double(:position), size: double(:size, width: 200, height: 400)) }
  let(:described_instance) { described_class.new(frame) }

  let(:subviews) do
    allow(CoreStructures::BinarySortInsertArray)
      .to receive(:new) do
        []
      end
  end

  before do
    subviews
  end

  describe "#set_needs_display" do
    subject { described_instance.set_needs_display }

    context "if layer is nil" do
      before do
        expect(described_instance.layer).to eq(nil)
      end

      it { is_expected.to eq(nil) }
    end

    context "if layer exists" do
      let(:layer) { double(:layer, set_needs_display: nil) }
      before do
        allow(described_instance)
          .to receive(:layer)
          .and_return(layer)
      end

      context "if the layer needs display already" do
        before do
          allow(layer)
            .to receive(:needs_display?)
            .and_return(true)
        end

        it { is_expected.to eq(nil) }

        it "doesn't call #set_needs_display on the layer" do
          expect(layer)
            .to_not receive(:set_needs_display)

          subject
        end

        it "doesn't call #set_needs_display on the super view" do
          described_instance.instance_variable_set(:@superview, double(:superview))

          expect(described_instance.superview)
            .to_not receive(:set_needs_display)

          subject
        end
      end

      context "if the layer doesn't display already" do
        before do
          allow(layer)
            .to receive(:needs_display?)
            .and_return(false)

          allow(described_instance)
            .to receive(:superview)
            .and_return(double(:superview, set_needs_display: nil))
        end

        it "calls #set_needs_display on the layer" do
          expect(layer)
            .to receive(:set_needs_display)

          subject
        end

        it "calls #set_needs_display on the super view" do
          expect(described_instance.superview)
            .to receive(:set_needs_display)

          subject
        end
      end
    end
  end

  describe "#frame" do
    subject { described_instance.frame }
    it { is_expected.to eq(frame) }
  end

  describe "#bounds" do
    subject { described_instance.bounds }
    it { is_expected.to eq(frame) }
  end

  describe "#bounds=" do
    let(:another_bounds) { double(:bounds, position: double(:position), size: double(:size)) }
    subject { described_instance.bounds = another_bounds }

    it "edits #bounds" do
      expect { subject }
        .to change { described_instance.bounds }
        .from(frame)
        .to(another_bounds)
    end

    context "when the size is the same" do
      let(:another_bounds) { double(:bounds, position: double(:position), size: frame.size) }
      it "doesn't change the frame size" do
        expect { subject }
          .to_not change { described_instance.frame }
      end
    end

    context "when the size is different" do
      before do
        expect(frame.size)
          .to_not eq(another_bounds.size)
      end

      it "changes the frame size" do
        new_rect = double(:new_rect)

        expect(CoreGraphics::Rectangle)
          .to receive(:new)
          .with(frame.position, another_bounds.size)
          .and_return(new_rect)

        expect { subject }
          .to change { described_instance.frame }
          .from(frame)
          .to(new_rect)
      end
    end
  end

  describe "#frame=" do
    let(:another_frame) { double(:frame, position: double(:position), size: double(:size)) }
    subject { described_instance.frame = another_frame }

    it "edits #frame" do
      expect { subject }
        .to change { described_instance.frame }
        .from(frame)
        .to(another_frame)
    end

    it "calls #set_needs_display" do
      expect(described_instance)
        .to receive(:set_needs_display)

      subject
    end

    context "when the size is the same" do
      let(:another_frame) { double(:frame, position: double(:position), size: frame.size) }

      it "doesn't change the bounds size" do
        expect { subject }
          .to_not change { described_instance.bounds }
      end
    end

    context "when the size is different" do
      before do
        expect(frame.size)
          .to_not eq(another_frame.size)
      end

      it "changes the bounds size" do
        new_rect = double(:new_rect, position: double(:new_position), size: double(:new_size))

        expect(CoreGraphics::Rectangle)
          .to receive(:new)
          .with(frame.position, another_frame.size)
          .and_return(new_rect)

        expect { subject }
          .to change { described_instance.bounds }
          .from(frame)
          .to(new_rect)
      end
    end

    context "if there's a layer" do
      let(:layer) { double(:layer, needs_display?: true) }

      before do
        described_instance.instance_variable_set(:@layer, layer)
      end

      it "nils it out so it can be regenerated" do
        expect { subject }
          .to change { described_instance.instance_variable_get(:@layer) }
          .from(layer)
          .to(nil)
      end
    end
  end

  describe "#background_color" do
    subject { described_instance.background_color }
    it { is_expected.to eq(UserInterface::Color.white) }
  end

  describe "#background_color=" do
    let(:color) { UserInterface::Color.red }
    subject { described_instance.background_color = color }

    it "edits #background_color" do
      expect { subject }
        .to change { described_instance.background_color }
        .from(UserInterface::Color.white)
        .to(color)
    end

    it "calls #set_needs_display" do
      expect(described_instance)
        .to receive(:set_needs_display)

      subject
    end
  end

  describe "#z_index" do
    subject { described_instance.z_index }
    it { is_expected.to eq(0) }
  end

  describe "#subviews" do
    subject { described_instance.subviews }
    it { is_expected.to be_empty }
  end

  describe "#hidden" do
    subject { described_instance.hidden }
    it { is_expected.to eq(false) }

    it "can be set" do
      described_instance.hidden = true
      expect(subject).to eq(true)
    end
  end

  describe "#layer" do
    subject { described_instance.layer }
    it { is_expected.to eq(nil) }

    context "when added to a window" do
      let(:frame) { double(:frame, position: double(:position), size: double(:size, width: 200, height: 400)) }
      let(:window) { UserInterface::Window.new(frame) }
      let(:add_subview) do
        window.add_subview(described_instance)
      end

      before do
        window.layer
      end

      it "builds a layer of the size of the view" do
        layer = double(:layer, set_needs_display: nil, needs_display?: false)

        scaled_size = double(:scaled_size)
        expect(CoreGraphics::Size)
          .to receive(:new)
          .with(
            frame.size.width * 2,
            frame.size.height * 2
          ).and_return(scaled_size)

        expect(CoreGraphics::Layer)
          .to receive(:new)
          .with(
            window.graphics_context,
            scaled_size
          )
          .and_return(layer)

        expect(layer)
          .to receive(:delegate=)
          .with(described_instance)

        add_subview
        expect(subject).to eq(layer)
      end

      it "retuns the same instance on successive calls" do
        add_subview
        expect(subject).to eql(described_instance.layer)
      end

      context "when removed from the window" do
        before do
          add_subview
          described_instance.remove_from_superview
        end

        it { is_expected.to eq(nil) }
      end
    end

    context "when added to a window indirectly" do
      let(:window) { UserInterface::Window.new(frame) }
      let(:superview) { UserInterface::View.new(frame) }
      before do
        window.add_subview(superview)
        superview.add_subview(described_instance)
      end

      it { is_expected.to be_a(CoreGraphics::Layer) }

      context "when removed from the window indirectly" do
        before do
          superview.remove_from_superview
        end

        it { is_expected.to eq(nil) }
      end

      context "when removed from the window indirectly after memoization" do
        before do
          expect(described_instance.layer).to be_a(CoreGraphics::Layer)
          superview.remove_from_superview
        end

        it { is_expected.to eq(nil) }
      end
    end
  end

  describe "#superview" do
    subject { described_instance.superview }
    it { is_expected.to eq(nil) }
  end

  describe "#window" do
    subject { described_instance.window }
    it { is_expected.to eq(nil) }

    context "when contained in a window directly" do
      let(:window) { UserInterface::Window.new(frame) }

      before do
        window.add_subview(described_instance)
      end

      it { is_expected.to eq(window) }
    end

    context "when contained in a view contained in a window" do
      let(:superview) { described_class.new(frame) }
      let(:window) { UserInterface::Window.new(frame) }

      before do
        superview.add_subview(described_instance)
        window.add_subview(superview)
      end

      it { is_expected.to eq(window) }
    end
  end

  describe "#add_subview" do
    let(:subview) { described_class.new(frame) }
    subject { described_instance.add_subview(subview) }

    it "adds the view to #subviews" do
      expect { subject }
        .to change { described_instance.subviews.count }
        .from(0)
        .to(1)

      expect(described_instance.subviews.first)
        .to eq(subview)
    end

    it "sets the child view's superview" do
      expect { subject }
        .to change { subview.superview }
        .from(nil)
        .to(described_instance)
    end

    context "when there is no window" do
      before do
        expect(subview.window).to eq(nil)
      end

      it "doesn't affect layer" do
        expect(subview.layer).to eq(nil)

        expect { subject }
          .to_not change { subview.layer }
      end
    end
  end

  describe "#remove_from_superview" do
    subject { described_instance.remove_from_superview }

    context "when the view has no parent" do
      before do
        expect(described_instance.superview).to eq(nil)
      end

      it "raises" do
        expect { subject }
          .to raise_error("Attempting to remove superview from a view without one")
      end
    end

    context "when the view has a superview" do
      let(:superview) { described_class.new(frame) }

      before do
        superview.add_subview(described_instance)
      end

      it "removes it" do
        expect { subject }
          .to change { described_instance.superview }
          .from(superview)
          .to(nil)
      end

      it "removes the child from the superview subviews" do
        expect { subject }
          .to change { superview.subviews.count }
          .from(1)
          .to(0)
      end
    end

    context "when the view had a layer" do
      let(:superview) { UserInterface::Window.new(frame) }

      before do
        superview.add_subview(described_instance)
      end

      it "clears it" do
        expect { subject }
          .to change { described_instance.layer }
          .from(instance_of(CoreGraphics::Layer))
          .to(nil)
      end
    end
  end
end
