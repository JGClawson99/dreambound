defmodule DreamboundWeb.SelectLive do
  use DreamboundWeb, :live_view

  def mount(params, session, socket) do
    {:ok, socket |> assign(:index, 0)}
  end


  def handle_event("card_swiped", %{"index" => index}, socket) do
    {:noreply, socket |> assign(:index, index)}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full h-full flex flex-col items-center space-y-24">
      <div class="swiper flex justify-center items-center w-[250px] h-[350px]" phx-hook="Flip" id="test2" >
        <div class="swiper-wrapper ">
          <div class="swiper-slide">
            <div class={["w-[250px] h-[350px] block", @index !== 0 && "hidden"]}  >
              <img src="/images/dragon.png" alt="test" class="w-full h-full objectcover" />
            </div>

            <div :if={@index > 0} class="w-[240px] h-[320px] flex justify-center items-center bg-blue-200 rounded-2xl">
              <div>
                Card {@index + 1}
              </div>
            </div>
          </div>

          <div class="swiper-slide rounded-2xl">
            <div class={["w-[250px] h-[350px] block"]}  >
              <img src="/images/cover.png" alt="test" class="w-full h-full" />
            </div>
          </div>
        </div>
      </div>

      <div phx-hook="Swiper" id="test" class="swiper mySwiper w-[120px] h-[160px]" phx-update="ignore">
        <div class="swiper-wrapper">
          <div class="swiper-slide flex items-center justify-center rounded-[18px] text-[22px] font-bold text-white">
            <div class="w-full h-full">
              <img src="/images/dragon.png" alt="test" class="w-full h-full rounded-2xl"  />
            </div>
          </div>
          <div class="swiper-slide flex items-center justify-center rounded-[18px] text-[22px] font-bold text-white bg-blue-200">Card 2</div>
          <div class="swiper-slide flex items-center justify-center rounded-[18px] text-[22px] font-bold text-white bg-blue-200">Card 3</div>
          <div class="swiper-slide flex items-center justify-center rounded-[18px] text-[22px] font-bold text-white bg-blue-200">Card 4</div>
        </div>
      </div>
    </div>
    """
  end
end
