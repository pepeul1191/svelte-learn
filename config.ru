require_relative 'config/environment.rb'

use ErrorController
use HomeController
use LoginController
use UploadController
use DepartmentController
use ProvinceController
use DistrictController

run ApplicationController