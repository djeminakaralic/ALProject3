page 50075 "Job description"
{
    AutoSplitKey = false;
    Caption = 'Job description';
    DataCaptionFields = "Job position Code";
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Job Description";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Perpose of job"; "Perpose of job")
                {
                    ApplicationArea = all;
                }
                field("Req. qualifications and skills"; "Req. qualifications and skills")
                {
                    ApplicationArea = all;
                }
                field(Manager; Manager)
                {
                    ApplicationArea = all;
                }
                field("Manager Name"; "Manager Name")
                {
                    ApplicationArea = all;
                }
                field("Job position Code"; "Job position Code")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SETCURRENTKEY("Job position ID");
    end;
}

