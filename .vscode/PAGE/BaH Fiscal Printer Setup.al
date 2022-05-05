page 50000 "BaH Fiscal Printer Setup"
{
    // BH1.00, Fiscal Process

    // Caption = 'Fiscal printer setup';
    PageType = List;
    SourceTable = "BaH Fiscal Printer Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Name; Name)
                {
                }
                field(Type; Type)
                {
                }
                field("COM port"; "COM port")
                {
                }
                field("IP Address"; "IP Address")
                {
                }
                field(Port; Port)
                {
                }
                field(Operator; Operator)
                {
                }
                field(Pass; Pass)
                {
                }
                field("Command File Path"; "Command File Path")
                {
                }
                field("Run File Path"; "Run File Path")
                {
                }
                field("Answer Path"; "Answer Path")
                {
                }
                field("Download for WebClient"; "Download for WebClient")
                {
                }
            }
        }
    }

    actions
    {
    }
}

