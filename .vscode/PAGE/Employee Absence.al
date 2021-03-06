page 51129 "Employee Absence"
//ED 01 START
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
                    trigger OnValidate()
                    begin
                        EditableHours := false;
                    end;
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
                    trigger OnValidate()
                    begin
                        CauseOfAbsence.Get("Cause of Absence Code");
                        /*   if CauseOfAbsence."Added To Hour Pool" then
                               EditableHours := true
                           else begin
                               EditableHours := false;
                               Hours := 0;
                           end;*/
                        EditableHours := true;
                        /*WageSetup.Get();
                        if Rec."Cause of Absence Code"= WageSetup."Overtime Code" then
                            EditableHours := true;*/
                    end;
                }
                field(Description; Description)
                {

                }
                field(Hours; Hours)
                {
                    Editable = EditableHours;
                    BlankZero = true;
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
            action("Insert Work Performance")
            {
                Caption = 'Insert Work Performance';
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var

                    WP: Record "Work performance";
                    WPPage: Page "Work Performance";
                begin
                    WP.Reset();
                    WP.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    WP.SetFilter("Month Of Performance", '%1', Date2DMY(Rec."From Date", 2));
                    WP.SetFilter("Year Of Performance", '%1', Date2DMY(Rec."From Date", 3));
                    WPPage.SetTableView(WP);
                    WPPage.Run();
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

        CauseOfAbsence.Get("Cause of Absence Code");
        if CauseOfAbsence."Added To Hour Pool" then
            if Hours = 0 then
                Error(Text008);
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
        WageSetup: Record "Wage Setup";
        EditableHours: Boolean;
        EmployeeAbsenceReg: Record "Employee Absence Reg";
        recEmplAbsence: Record "Employee Absence";
        recEmplAbsenceTemp: Record "Employee Absence" temporary;
        Text001: Label 'Set filters do not allow entry';
        Text004: Label 'Ending Date field cannot be blank.';
        Text007: Label 'Cause of Absence Code field cannot be blank.';
        Text008: Label 'Hours field cannot be blank.';
        CauseOfAbsence: Record "Cause of Absence";
    //ED 01 END
}