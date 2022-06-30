report 50074 "Reduction per Banks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reduction per Banks.rdl';
    Caption = 'Reduction per Banks';
    UseSystemPrinter = true;

    dataset
    {
        dataitem(DataItem5; "Reduction")
        {
            RequestFilterFields = BankAccountCode;
            column(Bank; DataItem5."Bank Name")
            {
            }
            column(InstallmentNo; DataItem5."No. of Installments paid")
            {
            }
            column(No; DataItem5."No.")
            {
            }
            column(Status; DataItem5.Status)
            {
            }
            column(PaidAmount; DataItem5."Paid Amount")
            {
            }
            column(Type_Reduction; DataItem5.Type)
            {
            }
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
            column(Type; Type)
            {
            }
            column(User; USERID)
            {
            }
            column(RDate; RDate)
            {
            }
            column(Name; Name)
            {
            }
            column(Description; DataItem5.Description)
            {
            }
            column(Party; DataItem5."Refer To Number")
            {
            }
            column(AccountNo; DataItem5.BankAccountCodeNo)
            {
            }
            column(FaxNo; FaxNo)
            {
            }
            dataitem(DataItem1; "Reduction per Wage")
            {
                DataItemLink = "Reduction No." = FIELD("No.");
                RequestFilterFields = "Wage Header No.";
                column(EmployeeNo; DataItem1."Employee No.")
                {
                }
                column(Amount; DataItem1.Amount)
                {
                }
                column(DateofCalculation; DataItem1."Date of Calculation")
                {
                }
                column(WHo; DataItem1."Wage Header No.")
                {
                }
                column(ReductionNo_ReductionperWage; DataItem1."Reduction No.")
                {
                }
                column(EmployeeNo_ReductionperWage; DataItem1."Employee No.")
                {
                }
                column(Amount_ReductionperWage; DataItem1.Amount)
                {
                }
                column(DateofCalculation_ReductionperWage; DataItem1."Date of Calculation")
                {
                }
                column(Type_ReductionperWage; DataItem1.Type)
                {
                }
                column(Rbr; RBr)
                {
                }
                column(Year; DataItem1."Year of Wage")
                {
                }
                column(Month; DataItem1."Month of Wage")
                {
                }

                trigger OnPreDataItem()
                begin
                    IF WH.GET("Wage Header No.")
                      THEN BEGIN
                        YearId := WH."Year Of Wage";
                        MonthID := WH."Month Of Wage";
                    END;
                    /* ELSE BEGIN
                       ERROR(Txt001);
                       END;*/

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Paid Amount");
                CompInfo.GET;
                RDate := TODAY;
                Name := '';
                CompInfo.CALCFIELDS(Picture);

                IF emp.GET("Employee No.") THEN
                    Name := emp."First Name" + ' ' + emp."Last Name";
                RBr += 1;

                IF RBA.GET(BankAccountCode)
                  THEN BEGIN
                    AccountNo := RBA."Account No";
                    FaxNo := RBA."Fax No."
                END;
            end;

            trigger OnPreDataItem()
            begin
                RBr := 0;
                AccountNo := '';
                FaxNo := '';
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

    var
        CompInfo: Record "Company Information";
        RDate: Date;
        Name: Text[250];
        emp: Record "Employee";
        RBr: Integer;
        WH: Record "Wage Header";
        MonthID: Integer;
        YearId: Integer;
        Txt001: Label 'You must enter Wage Header No.';
        RBA: Record "Wage/Reduction Bank Accounts";
        FaxNo: Text[30];
        AccountNo: Text[30];
}

