package br.pucpr.sabrh.entity
{

    [RemoteClass(alias="br.pucpr.sabrh.entity.Animal")]
    [Bindable]
    public class Animal
    {
        public var registro:String;
        public var nome:String;
        public var apelido:String;
        public var propriedade:Propriedade;
        public var pai:Animal;
        public var mae:Animal;
        public var dataNascimento:Date;
        public var sexo:String;
    }
}