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

            trigger OnAfterGetRecord()
            begin
                Employee.SetFilter("For Calculation", '%1', true);
                if Employee.FindFirst() then
                    repeat
                        EmployeeAbsence.SetFilter("Employee No.", '%1', Employee."No.");
                        EmployeeAbsence.SetFilter("From Date", '%1..%2', StartingDate, EndingDate);
                        if NOT EmployeeAbsence.FindFirst() then
                            AbsenceFill.EmployeeAbsence(StartingDate, EndingDate, Employee, WageSetup."Workday Code");


                    until Employee.Next() = 0;




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
        WageSetup: Record "Wage Setup";
        AbsenceFill: Codeunit "Absence Fill";
        StartingDate: Date;
        EndingDate: Date;
        LastEntry: Integer;
        Text0000: Label 'Registration of absences is completed.';








        Text0001: Label 'Employee Card is updated.';





    procedure SetEndingDate(Date: Date)
    begin


    end;


}
