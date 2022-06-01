page 50095 "Points per Disability Status"
{
    Caption = 'Points per Disability Status';
    PageType = List;
    SourceTable = "Points per Disability Status";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                //ED 02 START
                field(Category; Category)
                {
                    ApplicationArea = all;
                }
                //ED 02 END
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Points; Points)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Category = 0 THEN BEGIN
            /*Rec.FILTERGROUP(2);
            Rec.SETRANGE(Category, 0);
            Rec.FILTERGROUP(0);*/
            Message('Disability');
        END;
        IF Rec.Category = 1 THEN BEGIN
            /*Rec.FILTERGROUP(2);
            Rec.SETRANGE("Department Type", 4);
            Rec.SETRANGE("Department Category", Rec."Department Category");
            Rec.SETRANGE("Department Categ.  Description", Rec."Department Categ.  Description");
            Rec.FILTERGROUP(0);*/
            Message('Military');
        END;
        IF Rec.Category = 2 THEN BEGIN
            /*Rec.FILTERGROUP(2);
            Rec.SETRANGE("Department Type", 2);
            Rec.SETRANGE("Group Code", Rec."Group Code");
            Rec.SETRANGE("Group Description", Rec."Group Description");
            Rec.FILTERGROUP(0);*/
            Message('Conditions');
        END;

    end;
}

