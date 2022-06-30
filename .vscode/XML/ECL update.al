xmlport 50011 "ECL Update"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ECL Update';


    schema
    {
        textelement(Root)
        {
            tableelement("Employee Contract Ledger"; "Employee Contract Ledger")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'ECL';
                UseTemporary = false;
                textelement(VrstaAng)
                {
                    MinOccurs = Zero;
                }
                textelement(PrvoZaposlenje)
                {
                    MinOccurs = Zero;
                }
                textelement(NacinDolaska)
                {
                    MinOccurs = Zero;
                }
                textelement(PersonalniBr)
                {
                    MinOccurs = Zero;
                }



                trigger OnAfterInsertRecord()
                begin
                    "Employee Contract Ledger".Reset();
                    "Employee Contract Ledger".SetFilter("Employee No.", '%1', PersonalniBr);
                    if "Employee Contract Ledger".FindFirst() then begin
                        "Employee Contract Ledger".Validate("Engagement Type", VrstaAng);
                        if VrstaAng = 'NEODREĐENO' then
                            "Employee Contract Ledger".Validate("Contract Type", '1')
                        else
                            "Employee Contract Ledger".Validate("Contract Type", '2');
                        if PrvoZaposlenje = 'DA' then
                            "Employee Contract Ledger".Validate("First Time Employed", true)
                        else
                            "Employee Contract Ledger".Validate("First Time Employed", false);
                        if NacinDolaska = 'Iz radnog odnosa' then
                            "Employee Contract Ledger".Validate("Way of Employment", "Employee Contract Ledger"."Way of Employment"::"From Employment");
                        if NacinDolaska = 'Biro' then
                            "Employee Contract Ledger".Validate("Way of Employment", "Employee Contract Ledger"."Way of Employment"::"Employment Office");

                        if (NacinDolaska <> 'Iz radnog odnosa') and (NacinDolaska <> 'Biro') then
                            "Employee Contract Ledger".Validate("Way of Employment", "Employee Contract Ledger"."Way of Employment"::" ");

                        "Employee Contract Ledger".Modify();

                    end;











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




    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        EmpVec: Record Employee;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        EG: Record Employee;
        ER: Record Employee;
        Redoslijed: Integer;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
        AlternativeAddress: Record "Alternative Address";

        Department: Record Department;
        Slozen: Decimal;
        EmployeeU: Record Employee;
        Code2: Code[20];
        Code3: Code[20];
        HumanResSetup: Record "Human Resources Setup";
        Uslov: Decimal;

        Odgovor: Decimal;
}

