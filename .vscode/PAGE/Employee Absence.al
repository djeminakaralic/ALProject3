page 51129 "Employee Absence"
{
    Caption = 'Employee Absence';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Employee Absence Reg";

    layout
    {
        area(content)
        {
            repeater(s)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
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
                field("From Date"; "From Date")
                {

                }
                field("To Date"; "To Date")
                {

                }
                field("Cause of Absence Code"; "Cause of Absence Code")
                {

                }
                field(Description; Description)
                {

                }
                field(Approved; Approved)
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action("&Approve All")
            {
                Caption = '&Approve All';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Approved" = FALSE THEN BEGIN
                            REPEAT
                                Validate(Rec."Approved", TRUE);
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        /*ELSE BEGIN
                            REPEAT
                                Rec."Approved" := FALSE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0
                        END;*/
                    END;
                end;
            }

            action("&Unapprove All")
            {
                Caption = '&Unapprove All';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                begin
                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Approved" = TRUE THEN BEGIN
                            REPEAT
                                Validate(Rec."Approved", FALSE);
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        /*ELSE BEGIN
                            REPEAT
                                Rec."Approved" := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0
                        END;*/
                    END;
                end;
            }
        }
        area(processing)
        {

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF "Cause of Absence Code" = '' then
            Error(Text007);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF "From Date" = 0D then
            Error(Text001);

        IF "To Date" = 0D then
            ERROR(Text004);
    end;

    var
        Employee: Record "Employee";
        CurrPeriodStartDate: Date;
        CurrPeriodEndDate: Date;
        recEmplAbsence: Record "Employee Absence";
        recEmplAbsenceTemp: Record "Employee Absence" temporary;
        Text001: Label 'Set filters do not allow entry';
        Text004: Label 'Ending Date field cannot be blank.';
        Text007: Label 'Cause of Absence Code field cannot be blank.';
        CauseOfAbsence: Record "Cause of Absence";
        SettingNewFilters: Boolean;
        [InDataSet]
        ChangeAllowedVisible: Boolean;
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}