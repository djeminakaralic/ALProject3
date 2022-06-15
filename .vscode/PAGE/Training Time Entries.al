page 50067 "Training Time Entries"
{


    Caption = 'Evidencija održavanja treninga/edukacija';
    PageType = List;
    SourceTable = "Training Time Entry";
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; Code)
                {

                }
                field(Code2; Code2)
                {

                }
                field(TypeOF; TypeOF) { }
                field(Type; Type)
                {

                }

                field(Location; Location) { }
                field(Month; Month) { }
                field("Start date"; "Start date") { }
                field("End date"; "End date")
                {

                    trigger OnValidate()
                    var
                        AbsenceFill: Codeunit "Absence Fill";
                    begin

                        "Number of days" := AbsenceFill.GetHourPoolForVacation("Start date", "End date", 8) / 8;

                    end;
                }
                field("Number of days"; "Number of days")
                {

                }
                field(Status; Status) { }
                field("Number of people"; "Number of people") { }
                field("Travel cost home"; "Travel cost home") { }
                field("Travel cost ino"; "Travel cost ino") { }
                field("Daily rate home"; "Daily rate home")
                {
                    trigger OnValidate()
                    begin
                        "Daily rate home SUM" := "Daily rate home" * "Number of days";
                    end;
                }
                field("Daily rate ino"; "Daily rate ino")
                {
                    trigger OnValidate()
                    begin
                        "Daily rate ino SUM" := "Daily rate ino" * "Number of days";
                    end;
                }

                field("Daily rate home SUM"; "Daily rate home SUM") { }
                field("Daily rate ino SUM"; "Daily rate ino SUM") { }
                field(Kotizacija; Kotizacija) { }
                //field(Hours; Hours) { }
                field("Number of people attended"; "Number of people attended") { }


            }
        }


    }
}


