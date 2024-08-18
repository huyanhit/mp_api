<?php
namespace App\Providers;

use Illuminate\Support\ServiceProvider;

# Employee Info
use App\Repositories\Employee\EmployeeInfo\EmployeeInfoRepository;
use App\Repositories\Employee\EmployeeInfo\EmployeeInfoRepositoryInterface;

# Employee Contact
use App\Repositories\Employee\EmployeeContact\EmployeeContactRepository;
use App\Repositories\Employee\EmployeeContact\EmployeeContactRepositoryInterface;

# Employee Contract
use App\Repositories\Employee\EmployeeContract\EmployeeContractRepository;
use App\Repositories\Employee\EmployeeContract\EmployeeContractRepositoryInterface;

# Employee Dependent
use App\Repositories\Employee\EmployeeDependent\EmployeeDependentRepository;
use App\Repositories\Employee\EmployeeDependent\EmployeeDependentRepositoryInterface;

# Employee Insurance
use App\Repositories\Employee\EmployeeInsurance\EmployeeInsuranceRepository;
use App\Repositories\Employee\EmployeeInsurance\EmployeeInsuranceRepositoryInterface;

# Employee History Resolve


# Employee Bank
use App\Repositories\Employee\EmployeeBank\EmployeeBankRepository;
use App\Repositories\Employee\EmployeeBank\EmployeeBankRepositoryInterface;

#Employee Layoff
use App\Repositories\Employee\EmployeeLayoff\EmployeeLayoffRepository;
use App\Repositories\Employee\EmployeeLayoff\EmployeeLayoffRepositoryInterface;

# Position
use App\Repositories\Position\PositionRepository;
use App\Repositories\Position\PositionRepositoryInterface;

# Position Level
use App\Repositories\Position\PositionLevel\PositionLevelRepository;
use App\Repositories\Position\PositionLevel\PositionLevelRepositoryInterface;

# Position Title
use App\Repositories\Position\PositionTitle\PositionTitleRepository;
use App\Repositories\Position\PositionTitle\PositionTitleRepositoryInterface;

# Decision Question
use App\Repositories\Employee\DecisionQuestion\DecisionQuestionRepository;
use App\Repositories\Employee\DecisionQuestion\DecisionQuestionRepositoryInterface;

# Decision Answer
use App\Repositories\Employee\DecisionAnswer\DecisionAnswerRepository;
use App\Repositories\Employee\DecisionAnswer\DecisionAnswerRepositoryInterface;

# EmployeeConcurrent
use App\Repositories\Employee\EmployeeConcurrent\EmployeeConcurrentRepository;
use App\Repositories\Employee\EmployeeConcurrent\EmployeeConcurrentRepositoryInterface;

# EmployeeReceive
use App\Repositories\Employee\EmployeeReceive\EmployeeReceiveRepository;
use App\Repositories\Employee\EmployeeReceive\EmployeeReceiveRepositoryInterface;

# PersonnelProfile
use App\Repositories\Employee\Setting\PersonnelProfile\PersonnelProfileRepository;
use App\Repositories\Employee\Setting\PersonnelProfile\PersonnelProfileRepositoryInterface;

# Location
use App\Repositories\Location\LocationRepository;
use App\Repositories\Location\LocationRepositoryInterface;

# Type Contract
use App\Repositories\Employee\Setting\TypeContract\TypeContractRepository;
use App\Repositories\Employee\Setting\TypeContract\TypeContractRepositoryInterface;

# Workplace
use App\Repositories\Employee\Setting\Workplace\WorkplaceRepository;
use App\Repositories\Employee\Setting\Workplace\WorkplaceRepositoryInterface;

# Employee Certificate
use App\Repositories\Employee\EmployeeCertificate\EmployeeCertificateRepository;
use App\Repositories\Employee\EmployeeCertificate\EmployeeCertificateRepositoryInterface;
use App\Repositories\Employee\EmployeeInsuranceResolve\EmployeeInsuranceResolveRepository;
use App\Repositories\Employee\EmployeeInsuranceResolve\EmployeeInsuranceResolveRepositoryInterface;
use App\Repositories\Employee\EmployeeSalary\EmployeeSalaryRepository;
use App\Repositories\Employee\EmployeeSalary\EmployeeSalaryRepositoryInterface;
use App\Repositories\Employee\EmployeeAllowance\EmployeeAllowanceRepository;
use App\Repositories\Employee\EmployeeAllowance\EmployeeAllowanceRepositoryInterface;

# InsuranceRate
use App\Repositories\Employee\Setting\InsuranceRate\InsuranceRateRepository;
use App\Repositories\Employee\Setting\InsuranceRate\InsuranceRateRepositoryInterface;

# TypeAllowance
use App\Repositories\Employee\Setting\Allowance\AllowanceRepository;
use App\Repositories\Employee\Setting\Allowance\AllowanceRepositoryInterface;
use App\Repositories\Employee\Setting\Benefit\BenefitRepository;
use App\Repositories\Employee\Setting\Benefit\BenefitRepositoryInterface;
use App\Repositories\Employee\Setting\Careerpath\CareerpathRepository;
use App\Repositories\Employee\Setting\Careerpath\CareerpathRepositoryInterface;
use App\Repositories\Employee\Setting\JobHistory\JobHistoryRepository;
use App\Repositories\Employee\Setting\JobHistory\JobHistoryRepositoryInterface;
# Penance
use App\Repositories\Employee\Setting\Penance\PenanceRepository;
use App\Repositories\Employee\Setting\Penance\PenanceRepositoryInterface;

class HRMRepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {   
        # Employee Info
        $this->app->bind(EmployeeInfoRepositoryInterface::class, EmployeeInfoRepository::class);
        # Employee Contact
        $this->app->bind(EmployeeContactRepositoryInterface::class, EmployeeContactRepository::class);
        # Employee Contract
        $this->app->bind(EmployeeContractRepositoryInterface::class, EmployeeContractRepository::class);
        #Employee Dependent
        $this->app->bind(EmployeeDependentRepositoryInterface::class, EmployeeDependentRepository::class);
        #Employee Insurance
        $this->app->bind(EmployeeInsuranceRepositoryInterface::class, EmployeeInsuranceRepository::class);
        # Employee Bank
        $this->app->bind(EmployeeBankRepositoryInterface::class, EmployeeBankRepository::class);
        # Employee Layoff
        $this->app->bind(EmployeeLayoffRepositoryInterface::class, EmployeeLayoffRepository::class);
        # Position
        $this->app->bind(PositionRepositoryInterface::class, PositionRepository::class);
        # Position Level
        $this->app->bind(PositionLevelRepositoryInterface::class, PositionLevelRepository::class);
        # Position Title
        $this->app->bind(PositionTitleRepositoryInterface::class, PositionTitleRepository::class);
        #Decision Question
        $this->app->bind(DecisionQuestionRepositoryInterface::class, DecisionQuestionRepository::class);
        #Decision Answer
        $this->app->bind(DecisionAnswerRepositoryInterface::class, DecisionAnswerRepository::class);
        #Location
        $this->app->bind(LocationRepositoryInterface::class, LocationRepository::class);
        # PersonnelProfile
        $this->app->bind(PersonnelProfileRepositoryInterface::class, PersonnelProfileRepository::class);
        # Type Contract
        $this->app->bind(TypeContractRepositoryInterface::class, TypeContractRepository::class);
        # TypeAllowance
        $this->app->bind(AllowanceRepositoryInterface::class, AllowanceRepository::class);
        # Workplace
        $this->app->bind(WorkplaceRepositoryInterface::class, WorkplaceRepository::class);
        # Employee Concurrent
        $this->app->bind(EmployeeConcurrentRepositoryInterface::class, EmployeeConcurrentRepository::class);
        # Employee Receive
        $this->app->bind(EmployeeReceiveRepositoryInterface::class, EmployeeReceiveRepository::class);
        # Employee Certificate
        $this->app->bind(EmployeeCertificateRepositoryInterface::class, EmployeeCertificateRepository::class);
        # Employee
        $this->app->bind(EmployeeInsuranceRepositoryInterface::class, EmployeeInsuranceRepository::class);
        # Insurance Rate
        $this->app->bind(InsuranceRateRepositoryInterface::class, InsuranceRateRepository::class);
        # Salary Emloyee
        $this->app->bind(EmployeeSalaryRepositoryInterface::class, EmployeeSalaryRepository::class);
        #Employee History Resolve Insurance
        $this->app->bind(EmployeeInsuranceResolveRepositoryInterface::class, EmployeeInsuranceResolveRepository::class);
        # Employee Allowance
        $this->app->bind(EmployeeAllowanceRepositoryInterface::class, EmployeeAllowanceRepository::class);
        # Penance
        $this->app->bind(PenanceRepositoryInterface::class, PenanceRepository::class);
        # Employee History Setting
        $this->app->bind(JobHistoryRepositoryInterface::class, JobHistoryRepository::class);
        # Benefit Setting
        $this->app->bind(BenefitRepositoryInterface::class, BenefitRepository::class);
        # Certificate Setting
        $this->app->bind(EmployeeCertificateRepositoryInterface::class, EmployeeCertificateRepository::class);
        # Cereerpath Setting
        $this->app->bind(CareerpathRepositoryInterface::class, CareerpathRepository::class);
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
