report 50117 "Fill The Whole Month"
{
    Caption = 'Fill The Whole Month';
    ProcessingOnly = true;
    UseRequestPage = false;

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
                EmployeeCL: Record "Work Booklet";
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

        layout
        {
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
        WorkBooklet.RESET;
        WorkBooklet.SETFILTER(Coefficient, '<>%1', 1);
        WorkBooklet.SETFILTER(Status, '<>%1', WorkBooklet.Status::Terminated);
        IF WorkBooklet.FINDSET THEN
            REPEAT
                IF WorkBooklet."Ending Date" = 0D THEN
                    WorkBooklet."Ending Date" := TODAY;
                WorkBooklet.VALIDATE(Coefficient, WorkBooklet.Coefficient);
                WorkBooklet.MODIFY;

            UNTIL WorkBooklet.NEXT = 0;
        //MESSAGE(Text0001);
        MESSAGE('Završeno');
    end;


    var
        zadnji: Text[100];
        Str: Text[100];
        position: Integer;
        lenght: Integer;
        UkupniDani: Integer;
        UkupnoGodine: Integer;
        t_WorkBooklet: Record "Work Booklet";
        UkupniMjeseci: Integer;
        UkupniDaniBEZ: Integer;
        UkupnoGodineBEZ: Integer;
        UkupniMjeseciBEZ: Integer;
        EmployeeCL: Record "Work Booklet";
        DateRec: Date;
        EmployeeRec: Record "Employee";
        Text0001: Label 'Employee Card is updated.';
        wb: Record "Work Booklet";
        HumanResourcesSetup: Record "Human Resources Setup";
        EndingDate: Date;
        WageSetup: Record "Wage Setup";
        t_WorkBookletCurrent: Record "Work Booklet";
        WorkBooklet: Record "Work Booklet";
        TrenutniDani: Integer;
        TrenutniMjeseci: Integer;
        TrenutneGodine: Integer;
        BroughtTotal: Integer;
        BroughtTotalDays: Integer;
        BroughtTotalMonths: Integer;
        BroughtTotalYears: Integer;
        ECL: Record "Employee Contract Ledger";
        EmpNo: Code[10];
        UkupniSaVojnimGodine: Integer;
        UkupniSaVojnimMjeseci: Integer;
        UkupniSaVojnimDani: Integer;

        SviVojniGodine: Integer;
        SviVojniMjeseci: Integer;
        SviVojniDani: Integer;

    procedure SetEndingDate(Date: Date)
    begin


    end;

    procedure SetEmp(EmployeeNo: Code[10]; Date: Date)
    begin


    end;
}
