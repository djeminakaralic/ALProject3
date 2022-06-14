xmlport 50003 "Position Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Position Import';




    schema
    {
        textelement(Root)
        {
            tableelement("Position Menu"; "Position Menu")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'PositionMenu';
                UseTemporary = false;
                textelement(Pozicija)
                {
                    MinOccurs = Zero;
                }
                textelement(Slozenost)
                {
                    MinOccurs = Zero;
                }
                textelement(Odgovornost)
                {
                    MinOccurs = Zero;
                }
                textelement(Uslovi)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    Evaluate(Slozen, Slozenost);
                    Evaluate(Odgovor, Odgovornost);
                    Evaluate(Uslov, Uslovi);

                    "Position Menu".Reset();
                    "Position Menu".SetFilter(Description, '%1', Pozicija);

                    IF "Position Menu".FindFirst() THEN BEGIN
                        //slozen
                        //odg
                        //uslov

                        "Position Menu".validate("Position complexity", Slozen);
                        "Position Menu".Validate("Position Responsibility", Odgovor);
                        "Position Menu".Validate("Workplace conditions", Uslov);
                        "Position Menu".Modify();

                    END;
                END;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        MESSAGE(Text);
    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
        Slozen: Decimal;
        Uslov: Decimal;

        Odgovor: Decimal;
}

