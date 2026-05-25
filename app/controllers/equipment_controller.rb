class EquipmentController < ApplicationController
  before_action :set_equipment, only: [ :show, :update, :destroy ]

  def index
    equipment = Equipment.includes(:category).order(:name)

    if params[:status].present?
      equipment = equipment.where(status: params[:status])
    end

    render json: equipment.as_json(
      include: {
        category: {
          only: [ :id, :name ]
        }
      }
    )
  end

  def show
    maintenance_records = @equipment.maintenance_records.order(performed_at: :desc)

    render json: @equipment.as_json(
      include: {
        category: {
          only: [ :id, :name ]
        },
        maintenance_records: {
          methods: [],
          only: [ :id, :description, :performed_at ]
        }
      }
    ).merge(
      maintenance_records: maintenance_records
    )
  end

  def create
    category = Category.find_by(id: equipment_params[:category_id])

    unless category
      return render json: { error: "Category not found" }, status: :unprocessable_entity
    end

    equipment = Equipment.new(equipment_params)

    if equipment.save
      render json: equipment, status: :created
    else
      render json: { errors: equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    category = Category.find_by(id: equipment_params[:category_id])

    unless category
      return render json: { error: "Category not found" }, status: :unprocessable_entity
    end

    if @equipment.update(equipment_params)
      render json: @equipment
    else
      render json: { errors: @equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @equipment.destroy

    render json: { message: "Equipment deleted successfully" }
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  def equipment_params
    params.require(:equipment).permit(
      :name,
      :serial_number,
      :status,
      :category_id
    )
  end
end
