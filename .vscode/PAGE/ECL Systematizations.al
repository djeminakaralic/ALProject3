page 50144 "ECL Systematizations"
{
    ApplicationArea = BasicHR;
    Caption = 'Employees nk';
    //CardPageID = "Employee Card";
    Editable = false;
    PageType = List;
    SourceTable = "ECL Systematization";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Systematization)
            {
                field("Internal ID"; "Internal ID")
                {
                    Applicationarea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    Applicationarea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Applicationarea = all;
                }
                field("Reason for Change"; "Reason for Change")
                {
                    Applicationarea = all;
                }
                field("Difference Org/Position"; "Difference Org/Position")
                {
                    Applicationarea = all;
                }
                field("Org Belongs"; "Org Belongs")
                {
                    Applicationarea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Position Description"; "Position Description")
                {
                    Applicationarea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Position Code"; "Position Code")
                {
                    Applicationarea = all;
                }
                field("Will Be Changed Later"; "Will Be Changed Later")
                {
                    Applicationarea = all;
                }
                field("Changing Position"; "Changing Position")
                {
                    Applicationarea = all;
                }

                field("Branch Agency"; "Branch Agency")
                {
                    Applicationarea = all;
                }
                field(IS; IS)
                {
                    Applicationarea = all;
                }
                field("IS Date From"; "IS Date From")
                {
                    Applicationarea = all;
                }
                field("IS Date To"; "IS Date To")
                {
                    Applicationarea = all;
                }
                field("Org Unit Name"; "Org Unit Name")
                {
                    Applicationarea = all;
                }
                field("GF of work Description"; "GF of work Description")
                {
                    Applicationarea = all;
                }
                field("Phisical Department Desc"; "Phisical Department Desc")
                {
                    Applicationarea = all;
                }
                field("Regionalni Head Office"; "Regionalni Head Office")
                {
                    Applicationarea = all;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    Applicationarea = all;
                }
                field(Region; Region)
                {
                    Applicationarea = all;
                }
                field("Team Description"; "Team Description")
                {
                    Applicationarea = all;
                }
                field(Team; Team)
                {
                    Applicationarea = all;
                }
                field("Group Description"; "Group Description")
                {
                    Applicationarea = all;
                }
                field(Group; Group)
                {
                    Applicationarea = all;
                }
                field("Department Cat. Description"; "Department Cat. Description")
                {
                    Applicationarea = all;
                }
                field("Department Category"; "Department Category")
                {
                    Applicationarea = all;
                }
                field("Sector Description"; "Sector Description")
                {
                    Applicationarea = all;
                }
                field(Sector; Sector)
                {
                    Applicationarea = all;
                }
                field("Department Code"; "Department Code")
                {
                    Editable = false;
                    Applicationarea = all;
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Applicationarea = all;
                }
                field("Dimension  Name"; "Dimension  Name")
                {
                    Style = Unfavorable;
                    Applicationarea = all;
                    StyleExpr = TRUE;
                }
                field("Order By Managment"; "Order By Managment")
                {
                    Applicationarea = all;

                }
                field(Brutto; Brutto)
                {
                    Applicationarea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt003);
                    IF Response THEN BEGIN
                        CurrPage.SAVERECORD;

                        StepNext.RUN;
                        CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action(Previous)
            {
                Image = PreviousSet;
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt006);
                    IF Response THEN BEGIN
                        PreviousStep.RUN;
                        CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action(ShowRecord)
            {
                Caption = 'ShowRecord';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;
                RunObject = Report "Show record";
            }
            action(UpdateDep)
            {
                Caption = 'UpdateDep';
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Update dep";
                Applicationarea = all;

                trigger OnAction()
                begin
                    NewReport.RUN;
                end;
            }
            action(UpdateHeadOf)
            {
                Caption = 'UpdateHeadOf';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;
                RunObject = Report "Update Head Of table";
            }
        }
    }

    var
        Response: Boolean;
        StepNext: Page "Head Of's temporary sist";
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
        PreviousStep: Page "Position menu temp";
        NewReport: Report "Update Head Of table";
}
