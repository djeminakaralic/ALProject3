page 50065 "Head Of's"
{
    Caption = 'Head Of''s';
    Editable = true;
    PageType = List;
    SourceTable = "Head Of's";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ORG Shema"; "ORG Shema")
                {
                    ApplicationArea = all;
                }
                field("Team Description"; "Team Description")
                {
                    ApplicationArea = all;
                }
                field("Team Code"; "Team Code")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field("Department Categ.  Description"; "Department Categ.  Description")
                {
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Sector  Description"; "Sector  Description")
                {
                    ApplicationArea = all;
                    Caption = 'Sector Description';
                }
                field(Sector; Sector)
                {
                    ApplicationArea = all;
                }
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = true;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    Caption = 'First and Last name';
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;
                }
                field("Head's number of employee"; "Head's number of employee")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Show")
            {
                Caption = '&Show';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
            }
            action("Update head of")
            {
                Caption = 'Update head of';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Update Head Of orginal";
            }
        }
    }

    trigger OnOpenPage()
    begin
        OS.SETFILTER(Status, '%1', OS.Status::Active);
        IF OS.FINDFIRST THEN
            SETFILTER("ORG Shema", '%1', OS.Code);
    end;

    var
        OS: Record "ORG Shema";
}

