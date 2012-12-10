package # Hide from the indexer for now until docs are added later.
    MooseX::ExtraArgs::Meta::ToRole;
use Moose::Role;

around apply => sub{
    my $orig      = shift;
    my $self      = shift;
    my $from_role = shift;
    my $to_role   = shift;

    $to_role = Moose::Util::MetaRole::apply_metaroles(
        for            => $to_role,
        role_metaroles => {
            application_to_class => ['MooseX::ExtraArgs::Meta::ToClass'],
            application_to_role  => ['MooseX::ExtraArgs::Meta::ToRole'],
        },
    );

    return $self->$orig( $from_role, $to_role );
};

1;
