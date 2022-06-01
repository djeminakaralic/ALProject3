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
    //ED 02 START
    begin

        IF Rec.Category = 0 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Category, 0);
            Rec.FILTERGROUP(0);
        END;
        IF Rec.Category = 1 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Category, 1);
            Rec.FILTERGROUP(0);
        END;
        IF Rec.Category = 2 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Category, 2);
            Rec.FILTERGROUP(0);
        end;

    end;
    //ED 02 END
}

