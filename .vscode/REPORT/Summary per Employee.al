report 50053 "Summary per Employee"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Summary per Employee.rdl';
    Caption = 'Summary per Employee';

    dataset
    {
        dataitem(WC; "Wage Calculation")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("No." = FILTER(<> ''));
            RequestFilterFields = "No.", "Month Of Wage", "Year of Wage", "Wage Calculation Type";
            column(CompanyName; CompInfo.Name)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(User; USERID)
            {
            }
            column(IDYear; IDYear)
            {
            }
            column(EmployeeID; employee."Employee ID")
            {
            }
            column(LastName; LastName)
            {
            }
            column(FirstName; FirstName)
            {
            }
            column(No; "Employee No.")
            {
            }
            column(WageBase; "Wage (Base)")
            {
            }
            column(FinalNetWage; "Final Net Wage")
            {
            }
            column(WageReduction; "Wage Reduction")
            {
            }
            column(Payment; Payment)
            {
            }
            column(PreostaleUplateNetWage; "Net Wage")
            {
            }
            column(UnpaidHours; "Unpaid Absence Hours")
            {
            }
            column(PreostaleUplateNetWageAT; "Net Wage After Tax")
            {
            }
            column(TaxLineIndirectWageAdditionAmount; "Indirect Wage Addition Amount")
            {
            }
            column(TaxDeductions; "Tax Deductions")
            {
            }
            column(tax; Tax)
            {
            }
            column(Brutto; Brutto)
            {
            }
            column(WType; "Wage Calculation Type")
            {
            }
            column(ContributionFromBruto; "Contribution From Brutto")
            {
            }
            column(ContributionOverBruto; "Contribution Over Brutto")
            {
            }
            column(Transport; Transport)
            {
            }
            column(SatiMealToPay; "Meal to pay")
            {
            }
            column(AmountOverWage; "Contribution Over Brutto")
            {
            }
            column(HourPool; "Individual Hour Pool")
            {
            }
            column(Deduction; "Wage Reduction")
            {
            }
            column(WHO; "Wage Header No.")
            {
            }
            column(WageType; WageType)
            {
            }
            column(PDate; PDate)
            {
            }
            column(CDate; CDate)
            {
            }
            column(RDate; RDate)
            {
            }
            column(Kredit; Kredit)
            {
            }
            column(TD; WC."Tax Deductions")
            {
            }
            column(AdditionalTax; WC."Contribution Over Netto")
            {
            }

            trigger OnAfterGetRecord()
            var
                EmplDefDim: Record "Employee Default Dimension";
            begin
                IF employee.GET("Employee No.") THEN BEGIN
                    FirstName := employee."First Name";
                    LastName := employee."Last Name";
                END;
                CompInfo.CALCFIELDS(Picture);
                IF Filter = '' THEN
                    WageType := 'Svi'

                ELSE
                    WageType := Filter;

                IF WH.GET("Wage Header No.") THEN BEGIN
                    PDate := WH."Payment Date";
                    CDate := WH."Date Of Calculation";
                END;
                RDate := TODAY;

                RPE.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                RPE.SETFILTER("Employee No.", '%1', "Employee No.");
                RPE.SETFILTER(Type, '%1', 'KREDIT');

                Kredit := 0;
                IF RPE.FIND('-') THEN
                    REPEAT

                        Kredit += RPE.Amount;
                    UNTIL RPE.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                Filter := GETFILTER("Wage Calculation Type");
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

    trigger OnPreReport()
    begin
        CompInfo.GET;
    end;

    var
        CompInfo: Record "Company Information";
        employee: Record Employee;
        IDYear: Integer;
        FirstName: Text[50];
        LastName: Text[50];
        "Filter": Text[150];
        WageType: Text[150];
        WH: Record "Wage Header";
        WHO: Code[30];
        PDate: Date;
        CDate: Date;
        RDate: Date;
        RPE: Record "Reduction per Wage";
        Kredit: Decimal;
}

