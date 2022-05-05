page 50031 "Wage Wizard Step 3"
{
    Caption = 'Wage Wizard Step 3-Reductions';
    PageType = Card;
    SourceTable = "Wage Header";



    layout
    {
        area(content)
        {
            group(Basic)
            {

                Caption = 'Basic';

                group("Basic information")
                {

                    Caption = 'Basic';
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
                group("Wage Part")
                {
                    part(SubRedMain; "Wage Wizard Step 3 Subform RM")
                    {
                    }
                    part(SubRedTemp; "Wage Wizard Step 3 Subform RT")
                    {
                        SubPageLink = "Wage Header No." = FIELD("No.");
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
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page 50025;

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt002);
                    IF Response THEN BEGIN
                        ConfirmClose3 := FALSE;
                        Rec."Step 3" := TRUE;
                        CurrPage.SAVERECORD;
                        Step4.SETRECORD(Rec);
                        Step4.RUN;
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action(Cancel)
            {
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    WPClose.ClosedForm(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action(Previous)
            {
                Image = PreviousSet;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt006);
                    IF Response THEN BEGIN
                        ConfirmClose3 := FALSE;
                        RedTemp.RESET;
                        IF NOT RedTemp.ISEMPTY THEN
                            RedTemp.DELETEALL;
                        WPClose.ClosedForm(Rec);
                        Rec."Step 3" := FALSE;
                        CurrPage.SAVERECORD;
                        Step2.SETRECORD(Rec);
                        Step2.RUN;
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action(Activate)
            {
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    RedNo := '0000000000';
                    RedTemp.RESET;
                    IF RedTemp.FIND('+') THEN
                        RedNo := RedTemp."No.";
                    IF RedNo = '0000000000' THEN BEGIN
                        RedReal.RESET;
                        IF RedReal.FIND('+') THEN
                            RedNo := RedReal."No.";
                    END;

                    CurrPage.SubRedMain.PAGE.GETRECORD(RedMain);
                    IF RedMain."No." <> '' THEN BEGIN
                        RedReal.RESET;
                        RedReal.SETFILTER("Wage Header No.", Rec."No.");
                        RedReal.SETFILTER("Reduction No.", RedMain."No.");
                        IF NOT (RedReal.FIND('-')) THEN BEGIN
                            RedTemp.RESET;
                            RedTemp.SETFILTER("Wage Header No.", Rec."No.");
                            RedTemp.SETFILTER("Reduction No.", RedMain."No.");
                            IF NOT (RedTemp.FIND('-')) THEN
                                WITH RedTemp DO BEGIN
                                    INIT;
                                    RedNo := INCSTR(RedNo);
                                    "No." := RedNo;
                                    "Reduction No." := RedMain."No.";
                                    "Wage Header No." := Rec."No.";
                                    "Employee No." := RedMain."Employee No.";
                                    Amount := RedMain."Installment Amount";
                                    "User ID" := USERID;
                                    "Date of Calculation" := WageHeader."Date Of Calculation";
                                    INSERT;
                                END;
                        END;
                    END;
                    CurrPage.SubRedTemp.PAGE.RefreshMe(RedMain."No.");
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

    trigger OnClosePage()
    begin
        WPClose.ClosedForm(Rec);
    end;

    trigger OnInit()
    begin
        ConfirmClose3 := TRUE;
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin


        IF ConfirmClose3 THEN BEGIN
            Response := CONFIRM(Txt001);
            IF Response THEN
                WageHeader.RESET;
            WageHeader.SETRANGE(Status, 0);
            IF WageHeader.FIND('-') THEN
                WageHeader.DELETE;
            EXIT(Response);
        END
        ELSE
            EXIT(TRUE);
    end;

    var
        Step4: Page "Wage Wizard Step 4";
        Response: Boolean;
        ConfirmClose3: Boolean;
        WageHeader: Record "Wage Header";
        RecKey: Code[10];
        Step2: Page "Wage Wizard Step 2";
        RedMain: Record "Reduction";
        RedTemp: Record "Reduction per Wage Temp";
        RedReal: Record "Reduction per Wage";
        RedNo: Code[20];
        RecKey2: Integer;
        WPClose: Codeunit "Wage Precalculation";
        Txt001: Label 'Do you wish to exit Wage Calculation?';
        Txt002: Label 'Are you sure you wish to go to next step?';
        Txt006: Label 'Are you sure you wish to return to previous step?';
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

