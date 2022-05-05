page 50032 "Wage Addition"
{
    Caption = 'Wage Addition';
    PageType = List;
    SourceTable = "Wage Addition";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group2)
            {
                field("Wage Year"; YearFilter)
                {
                    Caption = 'Wage Year';

                    trigger OnValidate()
                    begin

                        WA.SETFILTER("Wage Header No.", '%1', '');
                        IF WA.FINDFIRST THEN
                            REPEAT
                            BEGIN
                                WA."Year of Wage" := YearFilter;
                                WA.MODIFY;
                            END
                            UNTIL WA.NEXT = 0;

                    end;
                }
                field("Wage Month"; MonthFilter)
                {
                    Caption = 'Wage Month';

                    trigger OnValidate()
                    begin
                        WA.SETFILTER("Wage Header No.", '%1', '');
                        IF WA.FINDFIRST THEN
                            REPEAT
                            BEGIN
                                WA."Month of Wage" := MonthFilter;
                                WA.MODIFY;
                            END
                            UNTIL WA.NEXT = 0;

                    end;
                }
            }
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field("Wage Addition Type"; "Wage Addition Type")
                {
                }
                field(Use; Use)
                {
                }
                field(Description; Description)
                {
                }
                field("Amount to Pay"; "Amount to Pay")
                {
                }
                field(Taxable; Taxable)
                {
                }
                field("Add. Taxable"; "Add. Taxable")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Calculated Amount"; "Calculated Amount")
                {
                }
                field(Brutto; Brutto)
                {
                }
                field("Year of Wage"; "Year of Wage")
                {
                }
                field("Month of Wage"; "Month of Wage")
                {
                }
                field("Wage Header No."; "Wage Header No.")
                {
                }
                field("Wage Header Entry No."; "Wage Header Entry No.")
                {
                }
                field(Locked; Locked)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF Employee.GET("Employee No.") THEN
            Name := Employee."Last Name" + ' ' + Employee."First Name"
        ELSE
            Name := '';
    end;

    trigger OnInit()
    begin
        //WH.FINDFIRST;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Month of Wage" := MonthFilter;
        "Year of Wage" := YearFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Name := '';
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

        MonthFilter := DATE2DMY(WORKDATE, 2);
        YearFilter := DATE2DMY(WORKDATE, 3);
        SETFILTER("Wage Header No.", '%1', '');
        /*
        SetFilters;*/

    end;

    var
        Name: Text[250];
        Employee: Record "Employee";
        YearFilter: Integer;
        MonthFilter: Integer;
        WageSetup: Record "Wage Setup";
        WH: Record "Wage Header";
        //ĐK WagePrecalculation: Codeunit "50001";
        //ĐK R_WorkExperience: Report "50041";
        //ĐK R_BroughtExperience: Report "50042";
        HasError: Boolean;
        //ĐKCalcWage: Codeunit "50002";
        WA: Record "Wage Addition";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure SetFilters()
    begin
        /*Rec.FILTERGROUP(2);
        Rec.SETRANGE("Month of Wage",MonthFilter);
        Rec.SETRANGE("Year of Wage",YearFilter);
        Rec.FILTERGROUP(0);*/
        //IF Rec."Employee No." = '' THEN Rec.DELETE;
        //CurrForm.UPDATECONTROLS;

    end;
}

