report 50117 "Fill The Whole Month"
{
    Caption = 'Fill The Whole Month';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Employee")
        {
            column(BroughtYearsofExperience_Employee; DataItem1."Brought Years of Experience")
            {
            }
            column(BroughtMonthsofExperience_Employee; DataItem1."Brought Months of Experience")
            {
            }
            column(BroughtDaysofExperience_Employee; DataItem1."Brought Days of Experience")
            {
            }
            column(YearsofExperienceinCompany_Employee; DataItem1."Years of Experience in Company")
            {
            }
            column(MonthsofExpinCompany_Employee; DataItem1."Months of Exp. in Company")
            {
            }
            column(DaysofExperienceinCompany_Employee; DataItem1."Days of Experience in Company")
            {
            }
            column(YearsofExperience_Employee; DataItem1."Years of Experience")
            {
            }
            column(MonthsofExperience_Employee; DataItem1."Months of Experience")
            {
            }
            column(DaysofExperience_Employee; DataItem1."Days of Experience")
            {
            }
            column(Military_Years_of_Service; DataItem1."Military Years of Service")
            {
            }
            column(Military_Months_of_Service; DataItem1."Military Months of Service")
            {
            }
            column(Military_Days_of_Service; DataItem1."Military Days of Service")
            {
            }
            column(Experience_With_Military_Years; DataItem1."Years with military")
            {
            }
            column(Experience_With_Military_Months; DataItem1."Months with military")
            {
            }
            column(Experience_With_Military_Days; DataItem1."Days with military")
            {
            }

            trigger OnAfterGetRecord()
            var
            begin
                Message(Text0001);
            end;

            trigger OnPreDataItem()
            begin

            end;
        }
    }

    requestpage
    {
        Caption = 'Insert Dates';
        ShowFilter = false;

        layout
        {
            area(content)
            {

                field(StartingDate; StartingDate)
                {
                    ApplicationArea = all;
                    Caption = 'Starting Date';
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = all;
                    Caption = 'Ending Date';
                }

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE(Text0000);
    end;


    var
        Employee: Record Employee;
        EmployeeAbsence: Record "Employee Absence";
        StartingDate: Date;
        EndingDate: Date;
        Text0000: Label 'Registration of absences is completed.';





        t_WorkBooklet: Record "Work Booklet";
        EmployeeCL: Record "Work Booklet";


        Text0001: Label 'Employee Card is updated.';

        HumanResourcesSetup: Record "Human Resources Setup";

        WageSetup: Record "Wage Setup";


        ECL: Record "Employee Contract Ledger";
        EmpNo: Code[10];


    procedure SetEndingDate(Date: Date)
    begin


    end;


}
