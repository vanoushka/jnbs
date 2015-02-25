class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_encryptor :credit_card, key: "dfsnkjiq3o4ytcioASDFASDFq345q2c424vbw4"
  attr_encryptor :cvv, key: "jsd9fsd9fASDFgt34St24"
  attr_encryptor :name, key: "sdfasdfGSDFGsdg44"
  attr_encryptor :last_name, key: "sdfasdfGSDFGsdg44"

  has_many :sales

  validates :credit_card, presence: true, format: {with: /\A(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})\z/}
  validates :cvv, presence: true, format: {with: /\A([0-9]){3,4}\z/}

  validates :name, presence: true, format: {with: /\A[A-ZÁÉÍÓÚÑ\s]{1}[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,49}\z/}
  validates :last_name, presence: true, format: {with: /\A[A-ZÁÉÍÓÚÑ\s]{1}[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,49}\z/}

  validates :username, presence: true, uniqueness: true,
            length: { in: 5..20, too_short: "Tiene que tener al menos 5 caracteres", too_long: "Máximo 20 caracteres" },
            format: { with: /([A-Za-z0-9\-\_\.]+)/, message: "Username sólo puede contener letras, números, guiones y puntos" }
  #validates :email, presence:true, format: {with: /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/}


end
