describe UserInterface::WindowDisplay do
  let(:window) do
    double(
      :window,
      graphics_context: double(
        :graphics_context,
        render_scale: 1.0,
        c__orbit: nil
      ),
      subviews: [],
      layer: double(
        :layer,
        draw: nil,
        c__draw: nil
      )
    )
  end
  let(:described_instance) { described_class.new(window) }

  describe "#draw" do
    subject { described_instance.draw }

    context "when the layer needs display" do
      before do
        allow(window.layer)
          .to receive(:needs_display?)
          .and_return(true)
      end

      it "tells the view layer to draw" do
        expect(window.layer)
          .to receive(:draw)

        subject
      end

      it "renders the drawn layer" do
        expect(window.layer)
          .to receive(:c__draw)

        subject
      end

      it "draws to the screen" do
        expect(window.graphics_context)
          .to receive(:c__orbit)

        subject
      end

      context "when the view has children" do
        let(:child1) do
          double(
            :child1,
            layer: double(
              :layer,
              needs_display?: false
            ),
            frame: double(:frame,
              position: double(:position, x: 10, y: 11),
              size: double(:size, width: 12, height: 13)
            )
          )
        end

        let(:child2) do
          double(
            :child2,
            layer: double(
              :layer,
              needs_display?: true,
              draw: nil
            ),
            frame: double(:frame,
              position: double(:position, x: 20, y: 21),
              size: double(:size, width: 22, height: 23)
            ),
            subviews: []
          )
        end

        before do
          window.subviews << child1
          window.subviews << child2

          allow(window.layer)
            .to receive(:draw_child_layer)
        end

        it "tells the layers that need to display to draw" do
          expect(child1.layer)
            .to_not receive(:draw)
          expect(child2.layer)
            .to receive(:draw)

          subject
        end

        it "draws the layer in the parent layer" do
          expect(window.layer)
            .to receive(:draw_child_layer)
            .with(
              child2.layer,
              20,
              21,
              22.0,
              23.0
            )

          subject
        end

        context "when the view has a content_offset" do
          before do
            allow(window)
              .to receive(:respond_to?)
              .with(:content_offset)
              .and_return(true)

            allow(window)
              .to receive(:content_offset)
              .and_return(double(:content_offset, x: 1, y: 2))
          end

          it "draws the layer in the parent layer with the offset" do
            expect(window.layer)
              .to receive(:draw_child_layer)
              .with(
                child2.layer,
                21,
                23,
                22.0,
                23.0
              )

            subject
          end
        end

        context "when the scale is different" do
          before do
            allow(window.graphics_context)
              .to receive(:render_scale)
              .and_return(2.0)
          end

          it "draws at scale" do
            expect(window.layer)
              .to receive(:draw_child_layer)
              .with(
                child2.layer,
                40,
                42,
                44.0,
                46.0
              )

            subject
          end
        end
      end
    end

    context "when the layer doesn't need display" do
      before do
        allow(window.layer)
          .to receive(:needs_display?)
          .and_return(false)
      end

      it "doesn't tell the view layer to draw" do
        expect(window.layer)
          .to_not receive(:draw)

        subject
      end
    end
  end
end
