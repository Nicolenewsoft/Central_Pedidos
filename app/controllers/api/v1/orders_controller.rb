module Api
  module V1
    class OrdersController < ApplicationController
      
      before_action :set_order, only: [:show, :update, :destroy]
      has_scope :by_channel, :by_status, :by_items

      #Function to pass the parameter purchase_channel, which will be used in the route
      def by_channel
        @orders = Order.by_channel(params[:purchase_channel])
        render json: @orders
      end
      #Function to pass the status parameter, which will be used in the route 
      def by_status
        @orders = Order.by_status(params[:status])
        render json: @orders
      end

      def by_items
        @orders = Order.by_items(params[:line_items])
        render json: @orders
      end

      # GET /api/v1/orders
      def index
        @orders = Order.all
        render json: @orders
      end

      # GET /api/v1/orders/id
      def show
        render json: @order
      end

      # POST /api/v1/orders
      def create
        @order = Order.new(order_params)

        if @order.save
          render json: @order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/orders/1
      def update
        if @order.update(order_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/orders/1
      def destroy
        @order.destroy
      end

      #It is good practice to declare callback methods as private
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_order
          @order = Order.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def order_params
          params.require(:order).permit(:ref, :purchase_channel, :cliente_name, :address, :total_value, :line_items, :status, :batch_id, :delivery_service)
        end
      end
  end
end
