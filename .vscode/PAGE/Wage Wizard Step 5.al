page 50028 "Wage Wizard Step 5"
{
    Caption = 'Wage Wizard Step 5-Closing';
    Editable = false;
    PageType = Card;
    SourceTable = "Wage Header";

    layout
    {
        area(content)
        {
            /* group(Basic)
             {
                 Caption = 'Basic';
                 grid("Basic Information")
                 {
                     GridLayout = Rows;
                     //Visible = false;
                     Group("Information of Wage2")

                     {


                         field("No."; "No.")
                         {
                         }
                         field("Year Of Wage"; "Year Of Wage")
                         {
                         }
                         field("Month Of Wage"; "Month Of Wage")
                         {
                         }
                         field(Description; Description)
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
                         field("User ID"; "User ID")
                         {
                         }
                         field("Wage Calculation Type"; "Wage Calculation Type")
                         {
                         }
                         field("Negative Payment"; "Negative Payment")
                         {
                             Importance = Promoted;
                             Style = Unfavorable;
                             StyleExpr = TRUE;

                             trigger OnDrillDown()
                             begin
                                 WCTemp.RESET;
                                 WCTemp.SETFILTER(Payment, '<%1', 0);
                                 WCPage.SETTABLEVIEW(WCTemp);
                                 WCPage.RUN;
                                 CurrPage.UPDATE;
                             end;
                         }
                     }
                     group(WagePart)
                     {
                         part("Wage Calculation Temp Subform"; "Wage Calculation Temp Subform")
                         {
                             SubPageLink = "Wage Header No." = FIELD("No.");
                             SubPageView = WHERE(MasterLine = CONST(false));
                         }
                     }
                 }
             }*/

            group("Basic") //globalna grupa
            {


                Caption = 'Basic';
                //The GridLayout property is only supported on controls of type Grid
                /*grid("Basic information")
                {
                    

                    GridLayout = Rows;
                    Visible = true;*/
                Group("Basic information of wage")

                {
                    Caption = '';

                    field("No."; "No.")
                    {
                    }
                    field("Year Of Wage"; "Year Of Wage")
                    {
                    }
                    field("Month Of Wage"; "Month Of Wage")
                    {
                    }
                    field(Description; Description)
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
                    field("User ID"; "User ID")
                    {
                    }
                    field("Wage Calculation Type"; "Wage Calculation Type")
                    {
                    }
                    field("Negative Payment"; "Negative Payment")
                    {
                        Importance = Promoted;
                        Style = Unfavorable;
                        StyleExpr = TRUE;

                        trigger OnDrillDown()
                        begin
                            WCTemp.RESET;
                            WCTemp.SETFILTER(Payment, '<%1', 0);
                            WCPage.SETTABLEVIEW(WCTemp);
                            WCPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                }

                //  }
                group("Wage part")
                {



                    Caption = '';




                    part("Wage Calculation Temp Subform"; "Wage Calculation Temp Subform")
                    {
                        SubPageLink = "Wage Header No." = FIELD("No.");
                        SubPageView = WHERE(MasterLine = CONST(false));
                    }
                }
                //}
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
                PromotedIsBig = true;
                Caption = 'Next step';


                trigger OnAction()
                begin
                    Rec.CALCFIELDS("Negative Payment");
                    IF Rec."Negative Payment" = 0 THEN BEGIN
                        Response := CONFIRM(Txt001);
                        IF Response THEN BEGIN
                            ConfirmClose := FALSE;
                            CloseCalc.CloseCalc(Rec);
                            DoNotActivateWPClose := TRUE;
                            /*IF Rec."Wage Calculation Type"=0 THEN BEGIN
                              R_Additions.SetWHNo(Rec."No.");
                             R_Additions.RUN;

                          END;*/
                            CurrPage.CLOSE;
                        END;
                    END
                    ELSE BEGIN
                        ERROR(Txt003);
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
        IF NOT DoNotActivateWPClose THEN
            WPClose.ClosedForm(Rec);
    end;

    trigger OnInit()
    begin
        DoNotActivateWPClose := FALSE;
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
        FILTERGROUP(0);
        RecKey := Rec."No.";
        RecKey2 := Rec."Entry No.";
        CurrPage.UPDATE(FALSE);
        DoNotActivateWPClose := FALSE;

        ConfirmClose := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        /*IF ConfirmClose THEN
          BEGIN
            Response:=CONFIRM(Txt002);
            EXIT(Response);
          END
        ELSE
          EXIT(TRUE);       */
        /*
       Response :=CONFIRM(Txt001);
       IF Response THEN
         BEGIN
           ConfirmClose := FALSE;
           CloseCalc.CloseCalc(Rec);
           DoNotActivateWPClose := TRUE;
           CurrPage.CLOSE;
         END;      */

    end;

    var
        Response: Boolean;
        RecKey: Code[10];
        Step4: Page "Wage Wizard Step 4";
        CloseCalc: Codeunit "Close Wage Calculation";
        RecKey2: Integer;
        WC: Record "Wage Calculation Temp";
        WPClose: Codeunit "Wage Precalculation";
        DoNotActivateWPClose: Boolean;
        ConfirmClose: Boolean;
        Txt001: Label 'Are you sure you wish to close this calculation?';
        Txt002: Label 'Are you sure you wish to return to previous step?';
        R_Additions: Report "Additions";
        WCPage: Page "Wage Calculation Subform";
        Txt003: Label 'Ne možete nastaviti dalje. Postoje obračun sa negativnom isplatom!';
        WCTemp: Record "Wage Calculation Temp";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

