page 50025 "Wage Wizard Step 4"
{
    Caption = 'Wage Wizard Step 4-Errors';
    PageType = Card;
    SourceTable = "Wage Header";
    /* UsageCategory = Administration;
     ApplicationArea = All;*/

    layout
    {
        area(content)
        {
            group(Basic)
            {
                Caption = 'Basic';

                group("Basic information")
                {

                    Caption = 'Basic information';
                    field("No."; "No.")
                    {
                    }
                    field("Year Of Wage"; "Year Of Wage")
                    {
                    }
                    field("Month Of Wage"; "Month Of Wage")
                    {
                    }
                    field("Entry No."; "Entry No.")
                    {
                    }
                    field(Description; Description)
                    {
                    }
                    field("Last Calculation In Month"; "Last Calculation In Month")
                    {
                    }
                    field(Status; Status)
                    {
                    }
                    field("Date Of Calculation"; "Date Of Calculation")
                    {
                    }
                    field("Year of Calculation"; "Year of Calculation")
                    {
                    }
                    field("Month of Calculation"; "Month of Calculation")
                    {
                    }
                    field("Closing Date"; "Closing Date")
                    {
                    }
                    field("User ID"; "User ID")
                    {
                    }
                    field("Wage Calculation Type"; "Wage Calculation Type")
                    {
                    }
                }
                group("Wage part")
                {



                    Caption = 'Wage Part';


                    part(ErrorSubform; "Wage Wizard Step 4 Subform Err")
                    {
                    }
                }
            }
            group(Parameters)
            {
                Caption = 'Parameters';
                field("Hour Pool"; "Hour Pool")
                {
                }
                field(Transportation; Transportation)
                {
                }
                field(Reduction; Reduction)
                {
                }
                field("Minimum Wage"; "Minimum Wage")
                {
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field("Temp Brutto"; "Temp Brutto")
                {
                }
                field("Temp Net Wage"; "Temp Net Wage")
                {
                }
                field("Temp Final Net Wage"; "Temp Final Net Wage")
                {
                }
                field("Temp Add. Tax From Brutto"; "Temp Add. Tax From Brutto")
                {
                }
                field("Temp Add. Tax Over Brutto"; "Temp Add. Tax Over Brutto")
                {
                }
                field("Temp Tax"; "Temp Tax")
                {
                }
                field("Temp Added Tax Per City"; "Temp Added Tax Per City")
                {
                }
                field("Temp Wage Reduction"; "Temp Wage Reduction")
                {
                }
                field("Temp Transport"; "Temp Transport")
                {
                }
                field("Temp Sick Leave-Company"; "Temp Sick Leave-Company")
                {
                }
                field("Temp Sick Leave-Fund"; "Temp Sick Leave-Fund")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Cancel)
            {
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF (Rec."No." <> xRec."No.") OR (Rec."Entry No." <> xRec."Entry No.") THEN BEGIN
            Rec.RESET;
            Rec.GET(RecKey, RecKey2);
        END;
    end;

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end

        FILTERGROUP(10);
        Rec.SETFILTER("No.", Rec."No.");
        Rec.SETRANGE("Entry No.", Rec."Entry No.");
        RecKey := Rec."No.";
        RecKey2 := Rec."Entry No.";
        FILTERGROUP(0);
    end;

    var
        RecKey: Code[10];
        ConfirmClose4: Boolean;
        RecKey2: Integer;
        Txt001: Label 'Are you sure you wish to go to next step?';
        Txt002: Label 'Critical errors were not corrected!';
        Txt006: Label 'Are you sure you wish to return to previous step?';
        Txt003: Label 'Do you wish to exit Wage Calculation?';
        TxtAddTaxFrom: Label 'Additional taxes from wages were not defined!';
        TxtAddTAxOver: Label 'Additional taxes over wages were not defined!';
        TxtTax: Label 'Taxes were not defined!';
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

