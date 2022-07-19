page 50110 "Cashier Activities"
{
    Caption = 'Cashier Activities';
    PageType = CardPart;
    SourceTable = "Cashier Cue";
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }
            cuegroup(Information)
            {
                Caption = 'Information';
                field("For Calculation"; "For Calculation")
                {
                    ApplicationArea = all;

                }
                field(Calculated; Calculated)
                {

                    ApplicationArea = all;
                }
                field("New Employees FC"; "New Employees FC")
                {
                    Image = Checklist;
                    Importance = Additional;
                    ApplicationArea = all;
                }
                field("Terminated Employees"; "Terminated Employees")
                {
                    Image = Checklist;
                    Importance = Additional;
                    ApplicationArea = all;
                }
                field("Wage Change"; "Wage Change")
                {
                    ApplicationArea = all;
                }
                field("For Calculation Witout Meal"; "For Calculation Witout Meal")
                {
                    ApplicationArea = all;
                }
                field("Negative Payment"; "Negative Payment")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        WageCalc.SETFILTER(Payment, '<%1', 0);
                        PAGE.RUNMODAL(50218, WageCalc);
                    end;
                }
                field(Additions; Additions)
                {
                    ApplicationArea = all;

                }
                field(Transfers; Transfers)
                {
                    ApplicationArea = all;
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }


        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        // SETFILTER("Due Date Filter",'<=%1',WORKDATE);
        //SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        // SETFILTER("User ID Filter",USERID);
        // SETRANGE(DateFilter5,CALCDATE('-'+ FORMAT(HRSetup."New employee period"),TODAY),TODAY);
        ThisMonthFirst := CALCDATE('-SM;', WORKDATE);
        ThisMonthLast := CALCDATE('SM', ThisMonthFirst);
        NextMonthFirst := CALCDATE('+1D', ThisMonthLast);
        NextMonthLast := CALCDATE('SM', NextMonthFirst);
        DBThisMonthLast := CALCDATE('SM-1D', ThisMonthFirst);
        DBThisMonthFirst := CALCDATE('-SM-1D;', WORKDATE);
        //SETRANGE(DateFilter6,ThisMonthFirst,ThisMonthLast);
        SETRANGE(DateFilter7, ThisMonthFirst, DBThisMonthLast);
        //SETRANGE(DateFilter8,01011980D,DBThisMonthFirst);
        SETRANGE(DateFilter9, CALCDATE('+1D;', ThisMonthFirst), ThisMonthLast);
        SETRANGE(DateFilterChange, ThisMonthFirst, ThisMonthLast);
    end;

    var

        ThisMonthFirst: Date;
        ThisMonthLast: Date;
        NextMonthFirst: Date;
        NextMonthLast: Date;
        DBThisMonthLast: Date;
        DBThisMonthFirst: Date;
        WageCalc: Record "Wage Calculation";
        WageCalcPage: Page "Wage Calculation Subform";
}

