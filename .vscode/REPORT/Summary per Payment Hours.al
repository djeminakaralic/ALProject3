report 50087 "Summary per Payment Hours"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Summary per Payment Hours.rdl';

    dataset
    {
        dataitem(DataItem1; "Wage Value Entry")
        {
            RequestFilterFields = "Document No.";
            column(No_Employee; DataItem1."Employee No.")
            {
            }
            column(PaymentType; DataItem1.Description)
            {
            }
            column(Amount; DataItem1.Hours)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            column(CEO; CompanyInfo.CEO)
            {
            }
            column(Hours; DataItem1.Hours)
            {
            }
            column(COADescription; UPPERCASE(COADescription))
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(COAType; COAType)
            {
            }
            column(ContributionFrom; ContributionFrom)
            {
            }
            column(ContributionOver; ContributionOver)
            {
            }
            column(ReductionType; ReductionType)
            {
            }
            column(Reduction; DataItem1."Reduction Type")
            {
            }
            column(Contribution; DataItem1."Contribution Type")
            {
            }
            column(ATFrom; DataItem1."AT From")
            {
            }
            column(ATFromNetto; DataItem1."AT From neto")
            {
            }
            column(Basis; DataItem1.Basis)
            {
            }
            column(PaymentTotal; WageHeader."Payment WVE")
            {
            }
            column(ReductiionTotal; WageHeader."Reduction WVE")
            {
            }
            column(ContributionFromTotal; WageHeader."Contribution From WVE")
            {
            }
            column(ContributionOverTotal; WageHeader."Contribution Over WVE")
            {
            }
            column(InternalID; InternalID)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(PostingGroup; PostingGroup)
            {
            }
            column(TotalTo; MealAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                COADescription := '';
                COA.SETFILTER("Short Code", '%1', Description);
                IF COA.FINDFIRST THEN BEGIN
                    COADescription := COA.Description;
                END
                ELSE BEGIN
                    WAT.SETFILTER(Code, '%1', Description);
                    IF WAT.FINDFIRST THEN BEGIN
                        COADescription := WAT.Description;
                    END
                    ELSE BEGIN
                        RED.SETFILTER(Code, '%1', Description);
                        IF RED.FINDFIRST THEN BEGIN
                            COADescription := RED.Description;
                        END
                        ELSE BEGIN
                            Contribution.SETFILTER("Short Code", '%1', Description);
                            IF Contribution.FINDFIRST THEN BEGIN
                                COADescription := Contribution.Description;
                                //   ContributionPercentage.SETFILTER(
                                //  Percentage:=Contribution.
                            END
                            ELSE
                                IF Description = '999' THEN
                                    COADescription := 'Minuli rad';
                            IF Description = '830' THEN
                                COADescription := 'Naknada za prevoz u novcu';

                        END;
                    END;
                END;
                Wve.RESET;
                Wve.SETFILTER("Document No.", '%1', WHNo);
                Wve.SETFILTER("Entry Type", '%1', "Entry Type"::"Meal to pay");
                Wve.SETFILTER("Employee No.", '%1', "Employee No.");
                IF Wve.FINDFIRST THEN BEGIN
                    Wve.CALCSUMS(Hours);
                    MealAmount := Wve.Hours;
                END
                ELSE BEGIN

                    MealAmount := 0;
                    ;
                END;
                IF Emp.GET("Employee No.") THEN BEGIN
                    InternalID := Emp."Internal ID";
                    EmpName := Emp."First Name" + ' ' + Emp."Last Name";
                    PostingGroup := Emp."Contribution Category Code";
                END;
            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER("Entry Type",'%1|%2|%3|%4|%5|%6|%7|%8|%9',2,6,7,9,10,11,12,13,14);
                SETFILTER("Entry Type", '<>%1', 0);
                SETFILTER("Contribution Type", '%1', '');
                SETFILTER("Reduction Type", '%1', '');
                CompanyInfo.GET;
                COADescription := '';

                WHNo := GETFILTER("Document No.");
                IF WHNo <> '' THEN BEGIN
                    WageHeader.GET(WHNo);
                    StartDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", TRUE);
                    EndDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);


                END;

                COAType := FALSE;
                ContributionFrom := FALSE;
                ContributionOver := FALSE;
                ReductionType := FALSE;
                Percentage := 0;
                InternalID := 0;
                EmpName := '';
                PostingGroup := '';
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

    trigger OnInitReport()
    begin
        T_HumanResourceSetup.GET;
    end;

    var
        T_HumanResourceSetup: Record "Human Resources Setup";
        CompanyInfo: Record "Company Information";
        COA: Record "Cause of Absence";
        COADescription: Text[250];
        WAT: Record "Wage Addition Type";
        RED: Record "Reduction types";
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        WHNo: Text;
        WageHeader: Record "Wage Header";
        Contribution: Record "Contribution";
        COAType: Boolean;
        ContributionFrom: Boolean;
        ContributionOver: Boolean;
        ReductionType: Boolean;
        COADescriptionR: Text[250];
        Percentage: Decimal;
        ContributionPercentage: Record "Contribution Category Conn.";
        Emp: Record "Employee";
        InternalID: Integer;
        EmpName: Text[250];
        PostingGroup: Code[10];
        TotalTo: Decimal;
        Wve: Record "Wage Value Entry";
        MealAmount: Decimal;
}

